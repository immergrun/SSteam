package com.ss.demo.service;

import java.util.List;

import com.ss.demo.domain.Criteria;
import com.ss.demo.domain.EventReviewVO;
import com.ss.demo.domain.EventVO;
import com.ss.demo.domain.RentalhomeVO;
import com.ss.demo.domain.Rentalhome_LikeVO;
import com.ss.demo.domain.Rentalhome_RoomVO;
import com.ss.demo.domain.SearchVO;



public interface EventService {
	
	
	
	public int EventInsert(EventVO ev);
	
	List<EventVO> list(SearchVO searchVO);
	
	public List<EventVO> selectAll_event_attach(int event_number);
	
	
	
	public EventVO selectOneByevent_number(int event_number);
	
	public int update(EventVO ev);
	
	public int delete_event(int event_number);
	
	public int select_event_count();
	
	public int insert_file(EventVO ev);
	
	public int insert_review(EventReviewVO erv);
	
	public List<EventReviewVO> selectAll_review(int comment_number);
	
	public EventReviewVO selectOneBycomment_number(int comment_number);
	
	public int update_review(EventReviewVO erv);
	
	public int delete_review(int comment_number);
	
	public int init_attach_thumbnail(int event_number);

	public int attach_thumbnail(int attach_number);
	
	public int delete_attach(int attach_number);

	List<EventVO> selectAll_event(EventVO ev);

	public List<EventVO> selectAll(Criteria cri);

	public int Insert(EventVO ev);
	
	
	//좋아요는 차후 수정
//	public int insert_like(Rentalhome_LikeVO likeVO);
//	
//	public int select_like(int rentalhome_idx);
//
//	public int dupl_like(Rentalhome_LikeVO likeVO);
//
//	public int delete_like(Rentalhome_LikeVO likeVO);

	
	




}
