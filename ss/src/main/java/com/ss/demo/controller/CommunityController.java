package com.ss.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ss.demo.domain.Community_BoardVO;
import com.ss.demo.domain.UserVO;
import com.ss.demo.service.CommunityService;

@RequestMapping (value = "/Community")
@Controller
public class CommunityController
{
	@Autowired
	private CommunityService communityService;
	
	// 페이지당 게시글 개수
	int unitPage = 10;
	// 페이징 블럭 크기
	int pagingBlockSize = 10;
	
	@RequestMapping (value = "/ChattingTest.do")
	public String toChattingTest()
	{
		return "Community/ChattingTest";
	}
	
	@RequestMapping (value = "/CommunityMain.do")
	public String toCommunityMain(@RequestParam(name = "boardType", defaultValue = "0") int boardType,
								  @RequestParam(name = "nowPage", defaultValue = "1") int nowPage,
            					  Model model)
	{
		// 게시글 정보 얻기
		int boardCount = 0;
		List<Community_BoardVO> nowPageBoardList;
		if (boardType == 0)
		{
			// System.out.println("전체 게시글");
			boardCount = communityService.getBoardCount();
			nowPageBoardList = communityService.getBoardPage(nowPage);
		}
		else
		{
			// System.out.println("특정 게시글");
			boardCount = communityService.getBoardCount_TypeChoice(boardType);
			nowPageBoardList = communityService.getBoardPage_TypeChoice(boardType, nowPage);
		}

		// 날짜형식 변경
		for (int i = 0; i < nowPageBoardList.size(); i++)
		{
			nowPageBoardList.get(i).setWrite_date(nowPageBoardList.get(i).getWrite_date().substring(0, 11));
		}
		// 모델에 게시글 전달
		model.addAttribute("nowPageBoardList", nowPageBoardList);
			
		// 최대 페이지 번호 계산
		int maxPage = (boardCount - 1) / unitPage + 1;
		// 페이징 블럭의 시작번호와 끝번호 계산
		int pageStart = ((nowPage - 1) / unitPage) * unitPage + 1;
		int pageEnd = pageStart + pagingBlockSize - 1;
		if (pageEnd > maxPage)
		{
			pageEnd = maxPage;
		}
		
		// System.out.println("boardType: " + boardType);
		// System.out.println("nowPage: " + nowPage);
		// System.out.println("boardCount: " + boardCount);
		// System.out.println("maxPage: " + maxPage);
		// System.out.println("pageStart: " + pageStart);		
		// System.out.println("pageEnd: " + pageEnd);

		// 모델에 파라미터 전달
		model.addAttribute("unitPage", unitPage);
		model.addAttribute("pagingBlockSize", pagingBlockSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("boardType", boardType);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("pageStart", pageStart);
		model.addAttribute("pageEnd", pageEnd);
		model.addAttribute("boardCount", boardCount);
		
		return "Community/CommunityMain";
	}
	
	@RequestMapping (value = "/CommunityWrite.do")
	public String toCommunityWrite(@RequestParam(name = "boardType", defaultValue = "2") int boardType,
								   Model model)
	{
		model.addAttribute("boardType", boardType);
		
		return "Community/CommunityWrite";
	}
	
	@RequestMapping (value = "/CommunityWriteCheck.do", method = RequestMethod.POST)
	public String communityWriteCheck(Community_BoardVO communityBoardVO, HttpServletRequest req)
	{
		HttpSession session = req.getSession();
		// System.out.println("user_number: " + req.getParameter("user_number"));
		// System.out.println("board_title: " + req.getParameter("board_title"));
		// System.out.println("board_type: " + req.getParameter("board_type"));
		// System.out.println("board_content: " + req.getParameter("board_content"));
		
		UserVO userVO = (UserVO)session.getAttribute("login");
		
		if(userVO == null)
		{
			return "redirect:CommunityMain.do";
		}
		else
		{
			communityService.insertBoard(communityBoardVO);
			return "redirect:CommunityMain.do";
		}
	}
	
	@RequestMapping (value = "/CommunityView.do")
	public String toCommunityView(@RequestParam(name = "boardNumber") int boardNumber,
								  @RequestParam(name = "isHit") boolean isHit,
								   Model model)
	{		
		// 게시글 정보 얻기
		Community_BoardVO communityBoardVO = communityService.readBoard(boardNumber, isHit);
		model.addAttribute("communityBoardVO", communityBoardVO);
		
		return "Community/CommunityView";
	}
	
	@RequestMapping (value = "/CommunityDelete.do")
	public String communityDelete(@RequestParam(name = "boardNumber") int boardNumber)
	{		
		// 게시글 삭제
		communityService.deleteBoard(boardNumber);
		
		return "redirect:CommunityMain.do";
	}
	
	@RequestMapping (value = "/CommunityModify.do")
	public String toCommunityModify(@RequestParam(name = "boardNumber") int boardNumber,
									Model model)
	{
		// 게시글 정보 얻기
		Community_BoardVO communityBoardVO = communityService.readBoard(boardNumber, false);
		model.addAttribute("communityBoardVO", communityBoardVO);
		
		return "Community/CommunityModify";
	}
	
	@RequestMapping (value = "/CommunityModifyCheck.do", method = RequestMethod.POST)
	public String communityModifyCheck(Community_BoardVO communityBoardVO, HttpServletRequest req)
	{
		HttpSession session = req.getSession();
		// System.out.println("user_number: " + req.getParameter("user_number"));
		// System.out.println("board_title: " + req.getParameter("board_title"));
		// System.out.println("board_type: " + req.getParameter("board_type"));
		// System.out.println("board_content: " + req.getParameter("board_content"));
		
		UserVO userVO = (UserVO)session.getAttribute("login");
		
		if(userVO == null)
		{
			return "redirect:CommunityMain.do";
		}
		else
		{
			communityService.updateBoard(communityBoardVO);
			return "redirect:CommunityMain.do";
		}
	}
}