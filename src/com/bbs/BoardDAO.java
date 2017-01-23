package com.bbs;

import java.util.List;

public interface BoardDAO {
	
	public int insertBoard(BoardDTO dto); //게시판에 글 올리는 메소드
	public int dataCount(); //검색이 아닌 상태의 갯수
	public int dataCount(String searchKey, String searchValue);
	public List<BoardDTO> listBoard(int start, int end); //검색이 아닌 상태
	public List<BoardDTO> listBoard(int start, int end, String searchKey, String searchValue);	//검색인 상태
	public int updateHitCount(int num);//조회수 가져오는
	public BoardDTO readBoard(int num); // 게시물 가져오기
	public BoardDTO preReadBoard(int num, String searchKey, String searchValue); //다음글 가져오기
    public BoardDTO nextReadBoard(int num, String searchKey, String searchValue);
	public int updateBoard(BoardDTO dto);//수정
	public int deleteBoard(int num);	//삭제
	
	public int insertReply(ReplyDTO dto); // 리플 저장용
	public int dataCountReply(int num); // 리플 개수
	public List<ReplyDTO> listReply(int num, int start, int end);// 리플
	public int deleteReply(int replyNum);//리플 삭제
}
