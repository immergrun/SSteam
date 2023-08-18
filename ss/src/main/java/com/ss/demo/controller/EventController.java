package com.ss.demo.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ss.demo.domain.Criteria;
import com.ss.demo.domain.EventReviewVO;
import com.ss.demo.domain.EventVO;
import com.ss.demo.domain.PageMaker;
import com.ss.demo.domain.RentalhomeVO;
import com.ss.demo.domain.Rentalhome_LikeVO;
import com.ss.demo.domain.Rentalhome_RoomVO;
import com.ss.demo.domain.SearchVO;
import com.ss.demo.domain.UserVO;
import com.ss.demo.service.EventService;




@Controller
@RequestMapping(value="/event")
public class EventController {
	
	@Autowired
	EventService es;
	
	@Autowired
	private PageMaker pageMaker;
	
	//메인창
	@RequestMapping(value="/eventMain.do")
	public String eventMain(Model model, SearchVO searchVO, Criteria cri) {
		/*
		 * List<String> list = new ArrayList<String>();
		 * 
		 * list.add("첫번째 게시물입니다."); list.add("두번째 게시물입니다."); list.add("세번째 게시물입니다.");
		 * list.add("네번째 게시물입니다.");
		 */
		/*
		 위 list 데이터를 board/list.jsp로 포워드하여 테이블 형태로 출력하세요.
		 */
		List<EventVO> list = es.selectAll(cri);
		model.addAttribute("list", list);
		
		int totalCount = es.select_event_count();
		
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		System.out.println(pageMaker.toString());
		model.addAttribute("pageMaker", pageMaker);
		
		String type = null;
		EventVO ev = new EventVO();
		ev.setLType(type);
		
		
		
		model.addAttribute("list", list);
		
		return "event/eventMain";
		
	}
	
	//상세보기
	@RequestMapping(value="/eventView.do")
	public String eventView(int event_number, Model model, SearchVO searchVO, HttpServletRequest req ){
		
	 EventVO ev = es.selectOneByevent_number(event_number);
	 model.addAttribute("ev", ev);
	 
	 List<EventVO> list_event_attach = es.selectAll_event_attach(event_number);
	 model.addAttribute("attach", list_event_attach);
	 
	 List<EventReviewVO> list = es.selectAll_review(event_number);
	 model.addAttribute("list", list);

//		int like_count = es.select_like(event_number);
//		System.out.println("like_count: "+like_count);
//		model.addAttribute("like_count", like_count);
		
//		if (req.getSession().getAttribute("login") != null) {
//	        UserVO loginVO = (UserVO) req.getSession().getAttribute("login");
//	        likeVO.setUno(loginVO.getuNo());
//	        int like_dupl = es.dupl_like(likeVO);
//	        model.addAttribute("like_dupl", like_dupl);
//		}
		return "event/eventView";
	}
	

	//이벤트 글쓰기
	@RequestMapping(value="/eventWrite.do", method=RequestMethod.GET)
	public String eventWrite(){
		
		return "event/eventWrite";
	}
	

	
		@RequestMapping(value = "/eventWrite.do", method=RequestMethod.POST)
		public String eventWrite(EventVO ev, @RequestParam("multiFile")
		List<MultipartFile> multiFileList, HttpServletRequest request)
		{

			// 이제 나머지 이벤트 데이터를 데이터베이스에 저장할 수 있습니다
			// 예를 들어, EventService를 호출하여 이벤트를 데이터베이스에 삽입할 수 있습니다.
			System.out.println("event_title : " + ev.getEvent_title());
			System.out.println("event_content : " + ev.getEvent_content());
			System.out.println("LType : " + ev.getLType());
		
			ev.setuNo(1);
			int value = es.Insert(ev);
			
			// 받아온것 출력 확인
			System.out.println("multiFileList : " + multiFileList);
			
			if( multiFileList.get(0).isEmpty() )
			{
				return "redirect:/event/eventMain.do?event_number="+ev.getEvent_number();
			}
			
			
			// path 가져오기
			String path = request.getSession().getServletContext().getRealPath("resources/upload");
			
			File file = new File(path);
			// 경로에 폴더가 없으면 폴더를 생성
			if(!file.exists()){
				file.mkdirs();
			}
			
			List<Map<String, String>> fileList = new ArrayList<>();
			
			for(int i = 0; i < multiFileList.size(); i++) {
				String originFile = multiFileList.get(i).getOriginalFilename();
				String etc = originFile.substring(originFile.lastIndexOf("."));
				String changeFile = originFile + UUID.randomUUID().toString() + etc;
				
				Map<String, String> map = new HashMap<>();
				map.put("originFile", originFile);
				map.put("changeFile", changeFile);
				
				fileList.add(map);
			}
			
			System.out.println("fileList: " + fileList);
			
			boolean flag = true;
			// 파일업로드
			try {
				for(int i = 0; i < multiFileList.size(); i++) {
					File uploadFile = new File(path + "\\" + fileList.get(i).get("changeFile"));
					multiFileList.get(i).transferTo(uploadFile);
					
					ev.setAttach_logical_name(fileList.get(i).get("originFile"));
					ev.setAttach_physical_name(fileList.get(i).get("changeFile"));
					
					if(flag) {
						ev.setThumbnail("Y");
						flag = false;
					}else {
						ev.setThumbnail("N");
					}
					System.out.println("EventVO 썸네일: " + ev.getThumbnail());
					es.insert_file(ev);
				}
				
				System.out.println("다중 파일 업로드 성공!");
				
			} catch (Exception e) {
				System.out.println("다중 파일 업로드 실패");
				// 만약 업로드 실패하면 파일 삭제
				for(int i = 0; i < multiFileList.size(); i++) {
					new File(path + "\\" + fileList.get(i).get("changeFile")).delete();
				}
				
				e.printStackTrace();
			}
			
			return "redirect:/event/eventMain.do";
		}
			
		//이벤트 수정
		@RequestMapping(value="/eventModify.do", method=RequestMethod.GET)
		public String eventModify(int event_number, Model model){
			
			EventVO ev = es.selectOneByevent_number(event_number);
			model.addAttribute("ev", ev);
			
			List<EventVO> list_event_attach= es.selectAll_event_attach(event_number);
			model.addAttribute("attach", list_event_attach);
			
			
			return "event/eventModify";
		}
		
		@RequestMapping(value="/eventModify.do", method=RequestMethod.POST)
		public String eventModify(
				EventVO ev ,
				@RequestParam("multiFile") List<MultipartFile> multiFileList,
				HttpServletRequest request){
			
			
			int value = es.update(ev);
			// 받아온것 출력 확인
			System.out.println("multiFileList : " + multiFileList);
			
			if( multiFileList.get(0).isEmpty() )
			{
				return "redirect:/event/eventMain.do?event_number="+ev.getEvent_number();
			}
			
			// path 가져오기
			String path = request.getSession().getServletContext().getRealPath("resources/upload");
			
			File file = new File(path);
			// 경로에 폴더가 없으면 폴더를 생성
			if(!file.exists()){
				file.mkdirs();
			}
			
			List<Map<String, String>> fileList = new ArrayList<>();
			
			for(int i = 0; i < multiFileList.size(); i++) {
				String originFile = multiFileList.get(i).getOriginalFilename();
				originFile.substring(originFile.lastIndexOf("."));
				String changeFile = UUID.randomUUID().toString() +  originFile;
				
				Map<String, String> map = new HashMap<>();
				map.put("originFile", originFile);
				map.put("changeFile", changeFile);
				
				fileList.add(map);
			}
			
			System.out.println("fileList: " + fileList);
			// 파일업로드
			try {
				for(int i = 0; i < multiFileList.size(); i++) {
					File uploadFile = new File(path + "\\" + fileList.get(i).get("changeFile"));
					multiFileList.get(i).transferTo(uploadFile);
					
					ev.setAttach_logical_name(fileList.get(i).get("originFile"));
					ev.setAttach_physical_name(fileList.get(i).get("changeFile"));
					ev.setThumbnail("N");
					System.out.println("ev 썸네일: " + ev.getThumbnail());
					
					es.insert_file(ev);
				}
				System.out.println("다중 파일 업로드 성공!");
				
			} catch (Exception e) {
				System.out.println("다중 파일 업로드 실패");
				// 만약 업로드 실패하면 파일 삭제
				for(int i = 0; i < multiFileList.size(); i++) {
					new File(path + "\\" + fileList.get(i).get("changeFile")).delete();
				}
				
				e.printStackTrace();
			}
			return "redirect:/event/eventView.do?event_number="+ev.getEvent_number();
			
		}
		
		
		//이벤트 삭제
		@RequestMapping(value="/eventDelete.do", method=RequestMethod.POST)
		public String eventDelete(int event_number){
			
			int value = es.delete_event(event_number);
			
			
			return "redirect:/event/eventMain.do";
		}
		
		@RequestMapping(value="/eventDelete.do", method=RequestMethod.GET)
		public String eventDelete(int event_number, Model model){
			
			EventVO ev = es.selectOneByevent_number(event_number);
			
			
			model.addAttribute("ev", ev);
			return "event/eventDelete";
		}

		//리뷰
		@RequestMapping(value="/eventReviewWrite.do",method=RequestMethod.GET)
		public String eventReviewWrite(int event_number, Model model){
			
			EventVO ev = es.selectOneByevent_number(event_number);
			model.addAttribute("ev", ev);
			
			
			return "event/eventReviewWrite";
		}
		@RequestMapping(value="/eventReviewWrite.do", method=RequestMethod.POST)
		public String eventReviewWrite(int event_number, EventVO ev, EventReviewVO erv){
			
		int value = es.insert_review(erv);
		System.out.println("Comment_title : " + erv.getComment_title());
		System.out.println("Comment_content : " + erv.getComment_content());
	
		return "redirect:/event/eventView.do?event_number="+ev.getEvent_number();
		}
		
		
		//리뷰수정
		@RequestMapping(value="/eventReviewModify.do", method=RequestMethod.GET)
		public String eventReviewModify(EventReviewVO erv, Model model, String event_title)
		{
			System.out.println(erv.toString());
			System.out.println("event_title"+ event_title);
			
			EventReviewVO erv_ = es.selectOneBycomment_number(erv.getComment_number());
			model.addAttribute("event_title", event_title);
			model.addAttribute("erv", erv_);
			
			return "event/eventReviewModify";
		}
		
		@RequestMapping(value="/eventReviewModify.do",method=RequestMethod.POST)
		public String eventReviewModify(EventReviewVO erv)
		{
			System.out.println(erv.toString());
			
			int value = es.update_review(erv);
			
			return "redirect:/event/eventView.do?event_number="+erv.getEvent_number();
		}
		
		
		//이벤트 리뷰삭제
		@RequestMapping(value="/eventReviewDelete.do" , method=RequestMethod.POST)
		public String eventReviewDelete(int comment_number, int event_number){
			
			
			System.out.println("comment_number"+comment_number);
			System.out.println("event_number"+event_number);
			int value = es.delete_review(comment_number);
			
				
			return "redirect:/event/eventView.do?event_number="+event_number;
		}
		
		
		
		@RequestMapping(value="/rentalhomeThumbnail.do", method=RequestMethod.POST)
		public String rentalhomeThumbnail(EventVO ev){
			
			int value1 = es.init_attach_thumbnail(ev.getEvent_number());
			
			int value2 = es.attach_thumbnail(ev.getAttach_number());
			
			
			return "event/eventView.do?event_number="+ev.getEvent_number();
		}
		
		
		@RequestMapping(value="/rentalhomeDelete_attach.do", method=RequestMethod.POST)
		public String rentalhomeDelete_room_attach(int attach_number, int event_number){
			
			int value = es.delete_attach(attach_number);
			
			return "redirect:/event/eventView.do?event_number="+event_number;
		}
		
		
		
//		@RequestMapping(value="/insert_like.do")
//		@ResponseBody
//		public int insert_like(Rentalhome_LikeVO likeVO) {
//			if(rentalhomeService.dupl_like(likeVO) == 0) {
//				rentalhomeService.insert_like(likeVO);
//				System.out.println("좋아요 등록 성공");
//				
//				return rentalhomeService.select_like(likeVO.getRentalhome_idx());
//			}else {
//				System.out.println("좋아요 중복");
//				return 0;
//			}
//		}
//
//		@RequestMapping(value="/delete_like.do")
//		@ResponseBody
//		public int delete_like(Rentalhome_LikeVO likeVO) {
//			if(rentalhomeService.dupl_like(likeVO) > 0) {
//				rentalhomeService.delete_like(likeVO);
//				System.out.println("좋아요 취소");
//				return rentalhomeService.select_like(likeVO.getRentalhome_idx());
//			}else {
//				System.out.println("좋아요를 누르지 않았습니다.");
//				return 0;
//			}
//		}
//		
//		
//		
//		
//	
//	
//	@RequestMapping(value ="/eventReviewWriteOk.do")
//	public String eventReviewWriteOk(EventReviewVO erv, HttpServletRequest request, EventVO ev)
//	{
//
//		// 이제 나머지 이벤트 데이터를 데이터베이스에 저장할 수 있습니다
//		// 예를 들어, EventService를 호출하여 이벤트를 데이터베이스에 삽입할 수 있습니다.
//		System.out.println("comment_content : " + erv.getComment_content());
//		
//		/*
//		 * HttpSession session = request.getSession(); UserVO
//		 * uv=(UserVO)session.getAttribute("login"); erv.setuNo(uv.getuNo());
//		 */
//		
//		erv.setuNo(1);
//		int value = es.EventReviewinsert(erv);
//		
//		
//		if (value > 0) {
//			// 이벤트 등록 성공 시, 성공 상태코드와 메시지를 출력하고 메인 페이지로 리다이렉트합니다.
//		System.out.println("이벤트 등록 성공");
//		} else {
//			// 이벤트 등록 실패 시, 실패 상태코드와 메시지를 출력하고 이벤트 작성 페이지로 리다이렉트합니다.
//		System.out.println("이벤트 등록 실패");
//		}
//
//		return "redirect:eventView.do?event_number="+ev.getEvent_number();
//	}
//	
//	
	

		
}
