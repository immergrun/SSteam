package com.ss.demo.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ss.demo.dao.EventDAO;
import com.ss.demo.domain.Criteria;
import com.ss.demo.domain.EventReviewVO;
import com.ss.demo.domain.EventVO;
import com.ss.demo.domain.RentalhomeVO;
import com.ss.demo.domain.Rentalhome_LikeVO;
import com.ss.demo.domain.SearchVO;
import com.ss.demo.persistence.EventService_Mapper;




@Service
public class EventServiceImpl implements EventService{
	
	@Autowired
	private EventDAO ed;
	//마이바티스에서  사용할 메소드 집합 
	private EventService_Mapper esm;
	// 맵퍼 불러오기 
	@Autowired
	public EventServiceImpl(SqlSession sqlSession) {
		this.esm = sqlSession.getMapper(EventService_Mapper.class);
	}
	
	@Override
	public List<EventVO> list(SearchVO searchVO) {
		
		return ed.list(searchVO);
	}
	

	
	@Override
	public int EventInsert(EventVO ev) {
		
		
		int value = esm.EventInsert(ev);
		return value;
	}

	 @Override
	 public EventVO selectOneByevent_number(int event_number) { 
		
		 return ed.selectOneByevent_number(event_number);
	  
	  }
	  
	  
	  @Override
	  public int update(EventVO ev) { 
		return ed.update(ev);
	  
	  }
	 
	@Override
	public int insert_file(EventVO ev) {
		
		return ed.insert_file(ev);
	}

	@Override
	public int delete_event(int event_number) {
		return ed.delete_event(event_number);
	}

	@Override
	public int insert_review(EventReviewVO erv) {
		return ed.insert_review(erv);
	}

	@Override
	public EventReviewVO selectOneBycomment_number(int comment_number) {
		
		return ed.selectOneBycomment_number(comment_number);
	}
	
	
	@Override
	public int update_review(EventReviewVO erv) {
		return ed.update_review(erv);
	}

	@Override
	public int delete_review(int comment_number) {
		return ed.delete_review(comment_number);
	}

	@Override
	public List<EventVO> selectAll_event_attach(int event_number) {
		return ed.selectAll_event_attach(event_number);
	}
	
	@Override
	public int init_attach_thumbnail(int event_number) {
		
		return ed.init_attach_thumbnail(event_number);
	}
	
	@Override
	public int attach_thumbnail(int attach_idx) {
		
		return ed.attach_thumbnail(attach_idx);
	}
	
	@Override
	public List<EventReviewVO> selectAll_review(int event_number) {
	
		return ed.selectAll_review(event_number);
	}

	@Override
	public int delete_attach(int event_number) {
		
		return ed.delete_attach(event_number);
	}

	@Override
	public int select_event_count() {
		
		return ed.select_event_count();
	}

	@Override
	public List<EventVO> selectAll_event(EventVO ev) {
	
		return ed.selectAll_event(ev);
	}

	@Override
	public List<EventVO> selectAll(Criteria cri) {
		return ed.selectAll(cri);
	}

	@Override
	public int Insert(EventVO ev) {
		return ed.insert(ev);
	}
	
//	@Override
//	public int insert_like(Rentalhome_LikeVO likeVO) {
//		
//		return rentalhomeDAO.insert_like(likeVO);
//	}
//
//	@Override
//	public int select_like(int rentalhome_idx) {
//		
//		return rentalhomeDAO.select_like(rentalhome_idx);
//	}
//
//	@Override
//	public int dupl_like(Rentalhome_LikeVO likeVO) {
//		
//		return rentalhomeDAO.dupl_like(likeVO);
//	}
//
//	@Override
//	public int delete_like(Rentalhome_LikeVO likeVO) {
//		
//		return rentalhomeDAO.delete_like(likeVO);
//	}
	
	
	
	
}
