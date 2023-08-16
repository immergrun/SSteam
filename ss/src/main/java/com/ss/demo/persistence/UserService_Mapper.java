package com.ss.demo.persistence;

import java.util.Map;

import com.ss.demo.domain.UserVO;


public interface UserService_Mapper {

	public int userInsert(UserVO uv);
	public UserVO userlogin(UserVO uv);
	
	public int uNickCheck(String uNick);
	// id 중복체크 
	public int uIdCheck(String uId);
	public UserVO uPwCheck(String uId);
	// 유저 조회 
	public UserVO userONE(UserVO uv);

	// 이미지 수정 
	public int profileimg(Map<String, Object> map);
	
	/*
	 * public userVO login(String uId); public int memberIdCheckcnt(String uId);
	 * public userVO memberLogin(String uId);
	 */
}
