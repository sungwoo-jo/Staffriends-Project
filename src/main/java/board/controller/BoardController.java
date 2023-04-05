package board.controller;

import board.vo.BoardVo;
import board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class BoardController {

    @Autowired
    private BoardService boardService;

    @RequestMapping({"/", ""})
    public String index() throws Exception {
        return "/index";
    }

    @RequestMapping("/board") // 게시글 목록
    public String openBoardList(Model model) throws Exception {
        List<BoardVo> list = boardService.selectBoardList();

        model.addAttribute("list", list);

        return "/board/boardList";
    }

    @RequestMapping("/board/boardWrite") // 글 작성 페이지
    public String BoardWrite() throws Exception {
        return "/board/boardWrite";
    }

    @RequestMapping("/board/insertBoard") // 글 작성 로직
    public String insertBoard(BoardVo boardVo) throws Exception {
        boardService.insertBoard(boardVo);
        return "redirect:/board";
    }

    @RequestMapping("/board/boardDetail") // 글 상세 보기
    public String openBoardDetail(@RequestParam int boardIdx, Model model) throws Exception {
        BoardVo boardVo = boardService.selectBoardDetail(boardIdx);
        model.addAttribute("board", boardVo);

        return "/board/boardDetail";
    }

    @RequestMapping("/board/updateBoard") // 글 수정
    public String updateBoard(BoardVo boardVo) throws Exception {
        boardService.updateBoard(boardVo);
        return "redirect:/board";
    }

    @RequestMapping("/board/deleteBoard") // 글 삭제
    public String deleteBoard(BoardVo boardVo) throws Exception {
        boardService.deleteBoard(boardVo);
        return "redirect:/board";
    }



}
