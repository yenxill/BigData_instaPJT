package egovframework.com.admin.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository("AdminDAO")
public class AdminDAO extends EgovAbstractMapper{

	public int insertMember(HashMap<String, Object> paramMap) {
		return insert("insertMember", paramMap);
	}

	public HashMap<String, Object> selectAdminLoginInfo(HashMap<String, Object> paramMap){
		return selectOne("selectAdminLoginInfo", paramMap);
	}

	public List<HashMap<String, Object>> selectFeedList(HashMap<String, Object> paramMap){
		return selectList("selectFeedList", paramMap);
	}

	public int insertFeed(HashMap<String, Object> paramMap) {
		return insert("insertFeed", paramMap);
	}

	public int updateFeed(HashMap<String, Object> paramMap) {
		return update("updateFeed", paramMap);
	}

	public int getFileGroupMaxSeq() {
		return selectOne("getFileGroupMaxSeq");
	}

	public int insertFileAttr(HashMap<String, Object> paramMap) {
		return insert("insertFileAttr", paramMap);
	}

	public List<HashMap<String, Object>> selectFileList(int feedIdx){
		return selectList("selectFileList", feedIdx);
	}

	public int deleteFeed(HashMap<String, Object> paramMap) {
		return update("deleteFeed", paramMap);
	}

	public int insertComment(HashMap<String, Object> paramMap) {
		return insert("insertComment", paramMap);
	}

	public int updateComment(HashMap<String, Object> paramMap) {
		return insert("updateComment", paramMap);
	}

	public int deleteFileInfo(HashMap<String, Object> paramMap) {
		return update("deleteFileInfo", paramMap);
	}

	public int deleteFileList(HashMap<String, Object> paramMap) {
		return update("deleteFileList", paramMap);
	}

	public int saveComment(HashMap<String, Object> paramMap) {
		return insert("saveComment", paramMap);
	}

	public List<HashMap<String, Object>> feedViewComment(int feedIdx){
		return selectList("feedViewComment", feedIdx);
	}

	// 댓글 삭제
	public int deleteFeedComment(HashMap<String, Object> paramMap) {
		return update("deleteFeedComment", paramMap);
	}

	public List<HashMap<String, Object>> selectFeedComment(int feedIdx) {
		return selectList("selectFeedComment", feedIdx);
	}

	//게시물 수정
	public HashMap<String, Object> selectFeedDetail(int feedIdx) {
		return selectOne("selectFeedDetail", feedIdx);
	}

	// 좋아요 등록
	public int insertFeedLike(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return insert("insertFeedLike", paramMap);
	}

	// 좋아요 취소
	public int updateFeedLike(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return update("updateFeedLike", paramMap);
	}
}
