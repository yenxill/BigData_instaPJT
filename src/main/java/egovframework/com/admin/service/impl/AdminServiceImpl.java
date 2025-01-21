package egovframework.com.admin.service.impl;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.admin.service.AdminService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("AdminService")
public class AdminServiceImpl extends EgovAbstractServiceImpl implements AdminService{

	@Resource(name="AdminDAO")
	private AdminDAO adminDAO;

	@Override
	public int insertMember(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return adminDAO.insertMember(paramMap);
	}

	@Override
	public HashMap<String, Object> selectAdminLoginInfo(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return adminDAO.selectAdminLoginInfo(paramMap);
	}

	@Override
	public List<HashMap<String, Object>> selectFeedList(HashMap<String, Object> paramMap) {
		List<HashMap<String, Object>> list = adminDAO.selectFeedList(paramMap);

		for (int i=0; i< list.size(); i++) {
            List<HashMap<String, Object>> fileList = null;
            HashMap<String, Object> feedMap = list.get(i);
          
            int feedIdx = Integer.parseInt(feedMap.get("feedIdx").toString());   
            
            // 파일 리스트 가져오기
            fileList = adminDAO.selectFileList(feedIdx);      
            
            // 파일 리스트에 전체 경로 추가
            for (HashMap<String, Object> fileMap : fileList) {
                String fileName = fileMap.get("saveFileName").toString(); // 파일 이름을 가져옴
                String fullPath = "C:\\ictsaeil\\insta\\" + fileName; // 전체 경로 구성
                fileMap.put("fullPath", fullPath); // 전체 경로 추가
            }
          
            feedMap.put("fileList", fileList);  // 파일 리스트를 feedMap에 추가
            
            List<HashMap<String, Object>> commentList = adminDAO.selectFeedComment(feedIdx); // 댓글 리스트 가져오기
            feedMap.put("commentList", commentList); // 댓글 리스트를 feedMap에 추가
          }
         
         System.out.println(list);
         
         return list;
	}

	@Override
	public int saveFeed(HashMap<String, Object> paramMap, List<MultipartFile> multipartFile) {
		// TODO Auto-generated method stub
		int resultChk = 0;

		String flag = paramMap.get("statusFlag").toString();
		int feedIdx  = 0;

		if("I".equals(flag)) {
			resultChk = adminDAO.insertFeed(paramMap);
			feedIdx  = adminDAO.getFileGroupMaxSeq();
			
		}else if("U".equals(flag)) {
			resultChk = adminDAO.updateFeed(paramMap);
			feedIdx = Integer.parseInt(paramMap.get("feedIdx").toString());
		}
		paramMap.put("fileGroupSeq", feedIdx);
		//파일 업로드
		int chk = 0;
		String filePath = "/ictsaeil/insta/";
		//		String deleteFiles = (String)paramMap.get("deleteFiles");

		String deleteFiles = "";
		if(paramMap.get("deleteFiles") != null ) {
			deleteFiles = (String)paramMap.get("deleteFiles");
		}
		
		if(deleteFiles.length() >0) {
			// 파일 테이블 데이터 삭제
			adminDAO.deleteFileList(paramMap);
		}

		if(multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
			int index = 0;
			for(MultipartFile file : multipartFile) {
				HashMap<String, Object> uploadFile = new HashMap<String, Object>();
				SimpleDateFormat date = new SimpleDateFormat("yyyyMMddHms");
				Calendar cal = Calendar.getInstance();
				String today = date.format(cal.getTime());
				try {
					// 파일 저장 처리
					File fileFolder = new File(filePath);
					if(!fileFolder.exists()) {
						if(fileFolder.mkdirs()) {
							System.out.println("[file.mkdirs] : Success");
						}
					}

					// 파일 정보 저장 및 파일 저장
					String fileExt = FilenameUtils.getExtension(file.getOriginalFilename());
					double fileSize = file.getSize();
					File saveFile = new File(filePath, "file_"+today+"_"+index+"."+fileExt);
					uploadFile.put("feedIdx", feedIdx);
					uploadFile.put("originalFileName", file.getOriginalFilename());
					uploadFile.put("saveFileName", "file_"+today+"_"+index+"."+fileExt); 
					uploadFile.put("saveFilePath", filePath);
					uploadFile.put("fileSize", fileSize);
					uploadFile.put("fileExt", fileExt);
					uploadFile.put("userId", paramMap.get("userId"));
					adminDAO.insertFileAttr(uploadFile);

					file.transferTo(saveFile);
					index++;
				}catch(Exception e) {
					e.printStackTrace();
					return 0;
				}
			}
		}

		return resultChk;
	}

	@Override
	public List<HashMap<String, Object>> selectFileList(int feedIdx) {
		// TODO Auto-generated method stub
		return adminDAO.selectFileList(feedIdx);
	}

	@Override
	public int deleteFeed(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		
		 int resultChk = 0;
	      resultChk = adminDAO.deleteFileInfo(paramMap);
	      resultChk = adminDAO.deleteFeed(paramMap); 
	      return resultChk;
	}
	
	// 댓글 save 기능 구현
	@Override
	public int saveComment(HashMap<String, Object> paramMap) {
	    // 결과 체크 초기화
		int resultChk = 0;

	    // 파라미터 맵에서 게시글 ID 가져오기
	    int feedIdx = Integer.parseInt(paramMap.get("feedIdx").toString());
	    paramMap.put("feedIdx", feedIdx);

	    try {
	        // 댓글 등록
	        resultChk = adminDAO.saveComment(paramMap);
	    } catch (Exception e) {
	        // 예외 로깅
	        e.printStackTrace(); // 또는 로거 사용
	    }

	    // 댓글 등록 결과 반환
	    return resultChk;
	}
	
	
	@Override
	public List<HashMap<String, Object>> feedViewComment(int feedIdx) {
		// TODO Auto-generated method stub
		return adminDAO.feedViewComment(feedIdx);
	}

	// 댓글 삭제 기능 구현
	@Override
	public int deleteFeedComment(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return adminDAO.deleteFeedComment(paramMap);
	}

	@Override
	public HashMap<String, Object> selectFeedDetail(int feedIdx) {
		// TODO Auto-generated method stub
//		return adminDAO.selectBoardDetail(feedIdx);
		
		 HashMap<String, Object> feedMap = adminDAO.selectFeedDetail(feedIdx);
	      // 댓글 리스트 가져오기
	      List<HashMap<String, Object>> commentList = adminDAO.selectFeedComment(feedIdx);
	      feedMap.put("commentList", commentList);
	      return feedMap;
	}

	// 좋아요 기능 구현
	@Override
	public int insertFeedLike(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		
		int resultChk = 0;
		String type = paramMap.get("likeType").toString();
		
		if("I".equals(type)) {
			resultChk = adminDAO.insertFeedLike(paramMap);
		}else if("U".equals(type)){
			resultChk = adminDAO.updateFeedLike(paramMap);
		}
		return resultChk;
	}
}
