package com.semiprj.controller;

import com.semiprj.model.QuizForm;
import com.semiprj.model.QuizVO;
import com.semiprj.model.QuestionVO;
import com.semiprj.model.UserGradeVO;
import com.semiprj.service.QuizServiceImpl;
import com.semiprj.service.QuestionServiceImpl;
import com.semiprj.service.UserGradeServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/quiz")
public class QuizController {

    @Autowired
    private QuizServiceImpl quizService;

    @Autowired
    private QuestionServiceImpl questionService;

    @Autowired
    private UserGradeServiceImpl userGradeService;

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateQuizForm(Model model, HttpSession session) {
        String userNickname = (String) session.getAttribute("userNickname");
        if (userNickname == null) {
            return "redirect:user/login";
        }

        QuizVO quizVO = new QuizVO();
        quizVO.setUserNickname(userNickname);
        model.addAttribute("quizVO", quizVO);
        return "quiz/createQuiz";
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String createQuiz(@Valid @ModelAttribute QuizVO quizVO, BindingResult bindingResult, HttpSession session) {
        if (bindingResult.hasErrors()) {
            return "quiz/createQuiz";
        }

        String userNickname = (String) session.getAttribute("userNickname");
        quizVO.setUserNickname(userNickname);
        quizVO.setStatus("INCOMPLETE");
        quizService.svcInsertQuiz(quizVO);
        return "redirect:/quiz/questionForm/" + quizVO.getQuizSeq() + "/" + quizVO.getQuestionCnt() + "/" + quizVO.getUserNickname();
    }

    @RequestMapping(value = "/questionForm/{quizSeq}/{questionCnt}/{userNickname}", method = RequestMethod.GET)
    public String showQuestionForm(@PathVariable("quizSeq") int quizSeq,
                                   @PathVariable("questionCnt") int questionCnt,
                                   @PathVariable("userNickname") String userNickname,
                                   Model model, HttpSession session) {
        String loggedInUserNickname = (String) session.getAttribute("userNickname");
        if (!userNickname.equals(loggedInUserNickname)) {
            return "quiz/error";
        }

        QuizForm quizForm = new QuizForm();
        List<QuestionVO> questions = new ArrayList<>();
        for (int i = 0; i < questionCnt; i++) {
            questions.add(new QuestionVO());
        }
        quizForm.setQuestions(questions);
        quizForm.setQuizSeq(quizSeq);
        quizForm.setUserNickname(userNickname);
        model.addAttribute("quizForm", quizForm);
        model.addAttribute("userNickname", userNickname);
        return "quiz/questionForm";
    }

    @RequestMapping(value = "/list/{userNickname}", method = RequestMethod.GET)
    public String listQuizzesByUser(@PathVariable("userNickname") String userNickname, Model model, HttpSession session) {
        String loggedInUserNickname = (String) session.getAttribute("userNickname");
        if (!userNickname.equals(loggedInUserNickname)) {
            return "quiz/error";
        }

        List<QuizVO> quizzes = quizService.getQuizzesByUserNickname(userNickname);
        model.addAttribute("quizzes", quizzes);
        model.addAttribute("userNickname", userNickname);
        model.addAttribute("quizVO", new QuizVO());
        return "quiz/quizList";
    }

    @RequestMapping(value = "/submitQuestions", method = RequestMethod.POST)
    public String submitQuestions(@Valid @ModelAttribute("quizForm") QuizForm quizForm, BindingResult result, Model model, HttpSession session) {
        String loggedInUserNickname = (String) session.getAttribute("userNickname");
        if (!quizForm.getUserNickname().equals(loggedInUserNickname)) {
            return "quiz/error";
        }

        if (result.hasErrors()) {
            model.addAttribute("userNickname", quizForm.getUserNickname());
            return "quiz/questionForm";
        }

        int quizSeq = quizForm.getQuizSeq();
        List<QuestionVO> questions = quizForm.getQuestions();
        for (QuestionVO question : questions) {
            question.setQuizSeq(quizSeq);
            questionService.svcInsertQuestion(question);
        }

        quizService.updateQuizStatusToComplete(quizSeq);

        return "redirect:/quiz/list/" + quizForm.getUserNickname();
    }

    @RequestMapping(value = "/solve/{quizSeq}", method = RequestMethod.GET)
    public String solveQuiz(@PathVariable("quizSeq") int quizSeq, Model model, HttpSession session) {
        QuizVO quiz = quizService.getQuizById(quizSeq);
        String userNickname = (String) session.getAttribute("userNickname");
        if (!quiz.getUserNickname().equals(userNickname)) {
            return "quiz/error";
        }

        List<QuestionVO> questions = questionService.getQuestionsByQuizId(quizSeq);
        QuizForm quizForm = new QuizForm();
        quizForm.setQuizSeq(quizSeq);
        quizForm.setQuestions(questions);
        quizForm.setUserNickname(userNickname);

        model.addAttribute("quizForm", quizForm);
        model.addAttribute("quizTitle", quiz.getQuizTitle());
        model.addAttribute("userNickname", userNickname);
        return "quiz/solveQuiz";
    }

    @RequestMapping(value = "/submitQuiz", method = RequestMethod.POST)
    public String submitQuiz(@ModelAttribute("quizForm") QuizForm quizForm, HttpSession session, Model model) {
        String userNickname = (String) session.getAttribute("userNickname");
        if (!quizForm.getUserNickname().equals(userNickname)) {
            return "quiz/error";
        }

        int quizSeq = quizForm.getQuizSeq();
        List<QuestionVO> questions = quizForm.getQuestions();
        int score = 0;

        for (QuestionVO question : questions) {
            if (question.getCorrectAnswer() == question.getUserAnswer()) {
                score++;
            }
        }

        UserGradeVO userGrade = new UserGradeVO();
        userGrade.setQuizSeq(quizSeq);
        userGrade.setUserNickname(quizForm.getUserNickname());
        userGrade.setScore(score);
        userGrade.setTotalQuestions(questions.size());
        userGradeService.svcInsertUserGrade(userGrade);

        String quizTitle = quizService.getQuizById(quizSeq).getQuizTitle();
        System.out.println("Quiz Title: " + quizTitle);

        try {
            String encodedQuizTitle = URLEncoder.encode(quizTitle, "UTF-8");
            return "redirect:/quiz/result?quizSeq=" + quizSeq + "&userNickname=" + userNickname + "&score=" + score + "&total=" + questions.size() + "&quizTitle=" + encodedQuizTitle;
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return "quiz/error";
        }
    }

    @RequestMapping(value = "/updateForm/{quizSeq}", method = RequestMethod.GET)
    public String showUpdateQuizForm(@PathVariable("quizSeq") int quizSeq, Model model, HttpSession session) {
        String userNickname = (String) session.getAttribute("userNickname");
        if (userNickname == null) {
            return "redirect:user/login";
        }

        QuizVO quizVO = quizService.getQuizById(quizSeq);
        if (!quizVO.getUserNickname().equals(userNickname)) {
            return "quiz/error";
        }

        model.addAttribute("quizVO", quizVO);
        return "quiz/updateQuiz";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateQuiz(@Valid @ModelAttribute QuizVO quizVO, BindingResult bindingResult, HttpSession session) {
        if (bindingResult.hasErrors()) {
            return "quiz/updateQuiz";
        }

        String userNickname = (String) session.getAttribute("userNickname");
        if (!quizVO.getUserNickname().equals(userNickname)) {
            return "quiz/error";
        }

        quizService.svcUpdateQuiz(quizVO);
        return "redirect:/quiz/updateQuestionsForm/" + quizVO.getQuizSeq() + "/" + quizVO.getQuestionCnt();
    }

    @RequestMapping(value = "/updateQuestionsForm/{quizSeq}/{questionCnt}", method = RequestMethod.GET)
    public String showUpdateQuestionsForm(@PathVariable("quizSeq") int quizSeq, @PathVariable("questionCnt") int questionCnt, Model model, HttpSession session) {
        String userNickname = (String) session.getAttribute("userNickname");
        if (userNickname == null) {
            return "redirect:user/login";
        }

        QuizVO quizVO = quizService.getQuizById(quizSeq);
        if (!quizVO.getUserNickname().equals(userNickname)) {
            return "quiz/error";
        }

        List<QuestionVO> questions = questionService.getQuestionsByQuizId(quizSeq);
        int currentQuestionCount = questions.size();

        if (questionCnt > currentQuestionCount) {
            for (int i = currentQuestionCount; i < questionCnt; i++) {
                questions.add(new QuestionVO());
            }
        } else if (questionCnt < currentQuestionCount) {
            questions = questions.subList(0, questionCnt);
        }

        QuizForm quizForm = new QuizForm();
        quizForm.setQuizSeq(quizSeq);
        quizForm.setQuestions(questions);
        quizForm.setUserNickname(userNickname);

        model.addAttribute("quizForm", quizForm);
        return "quiz/updateQuestions";
    }

    @RequestMapping(value = "/updateQuestions", method = RequestMethod.POST)
    public String updateQuestions(@Valid @ModelAttribute("quizForm") QuizForm quizForm, BindingResult result, Model model, HttpSession session) {
        String userNickname = (String) session.getAttribute("userNickname");
        if (!quizForm.getUserNickname().equals(userNickname)) {
            return "quiz/error";
        }

        if (result.hasErrors()) {
            return "quiz/updateQuestions";
        }

        List<QuestionVO> questions = quizForm.getQuestions();
        List<QuestionVO> existingQuestions = questionService.getQuestionsByQuizId(quizForm.getQuizSeq());

        if (questions.size() < existingQuestions.size()) {
            for (int i = questions.size(); i < existingQuestions.size(); i++) {
                questionService.deleteQuestion(existingQuestions.get(i).getQuestionSeq());
            }
        }

        for (QuestionVO question : questions) {
            question.setQuizSeq(quizForm.getQuizSeq());
            if (question.getQuestionSeq() == 0) {
                questionService.svcInsertQuestion(question);
            } else {
                questionService.svcUpdateQuestion(question);
            }
        }

        return "redirect:/quiz/list/" + userNickname;
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String deleteQuiz(@RequestParam("quizSeq") int quizSeq, @RequestParam("userNickname") String userNickname) {
        quizService.deleteQuiz(quizSeq);
        return "redirect:/quiz/list/" + userNickname;
    }

    @RequestMapping(value = "/result", method = RequestMethod.GET)
    public String showQuizResult(@RequestParam("quizSeq") int quizSeq,
                                 @RequestParam("userNickname") String userNickname,
                                 @RequestParam("quizTitle") String quizTitle,
                                 @RequestParam("total") int total,
                                 Model model, HttpSession session) {
        String loggedInUserNickname = (String) session.getAttribute("userNickname");
        if (!userNickname.equals(loggedInUserNickname)) {
            return "quiz/error";
        }

        System.out.println("showQuizResult called with quizSeq: " + quizSeq + " and userNickname: " + userNickname);

        UserGradeVO latestResult = userGradeService.getLatestUserGrade(quizSeq, userNickname);
        System.out.println("Latest Result: " + latestResult);

        List<UserGradeVO> previousResults = userGradeService.getUserGradesByQuizAndUser(quizSeq, userNickname);
        System.out.println("Previous Results: " + previousResults);

        model.addAttribute("latestResult", latestResult);
        model.addAttribute("previousResults", previousResults);
        model.addAttribute("quizTitle", quizTitle);
        model.addAttribute("total", total);

        return "quiz/quizResult";
    }
}
