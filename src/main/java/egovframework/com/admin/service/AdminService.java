package egovframework.com.admin.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface AdminService {
	
	public int insertMember(HashMap<String, Object> paramMap);
	
	public HashMap<String, Object> selectAdminLoginInfo(HashMap<String, Object> paramMap);
	
	public List<HashMap<String, Object>> selectFeedList(HashMap<String, Object> paramMap);
	
	public int saveFeed(HashMap<String, Object> paramMap, List<MultipartFile> multipartFile);
	
	public List<HashMap<String, Object>> selectFileList(int feedIdx);
	
	public int deleteFeed(HashMap<String, Object> paramMap);
	
	public int saveComment(HashMap<String, Object> paramMap);
	
	public List<HashMap<String, Object>> feedViewComment(int feedIdx);

	public int deleteFeedComment(HashMap<String, Object> paramMap);

	public HashMap<String, Object> selectFeedDetail(int feedIdx);

	public int insertFeedLike(HashMap<String, Object> paramMap);

	
	

	
}
