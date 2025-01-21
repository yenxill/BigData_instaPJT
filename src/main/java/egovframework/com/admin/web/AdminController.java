package egovframework.com.admin.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.admin.service.AdminService;
import egovframework.com.util.SHA256;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AdminController {
	 SHA256 sha256 = new SHA256();
	
	@Resource(name="AdminService")
	private AdminService adminService;
	
	//로그인
	@RequestMapping("/admin.do")
	public String admin() {
		return "/admin/adminLogin";
	}
	
	//회원가입 화면
	@RequestMapping("/join.do")
	public String join() {
		return "/join/instajoin";
	}
	
	//로그아웃
	@RequestMapping("/logout.do")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("loginInfo", null);
		session.removeAttribute("loginInfo");
		session.invalidate();
		return "redirect:/admin.do";
	}

	/*
	//프로필 화면
	@RequestMapping("/mypage.do")
	public String mypage() {
		return "/feed/myPage";
	}
	*/
	
	@RequestMapping("/admin/loginAction.do")
	   public String loginAction(HttpSession session, @RequestParam HashMap<String, Object> paramMap) {
	      // 입력받은 패스워드      
	      String pwd = paramMap.get("userPw").toString();
	      
	      // 암호화된 패스워드
	      // String encryptPwd = sha256.encrypt(pwd).toString(); // loginAction 옆에 throws Exception 써줘야함      
	      String encryptPwd = null;
	      
	      try {
	         encryptPwd = sha256.encrypt(pwd).toString();
	         paramMap.replace("userPw", encryptPwd);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      
	      HashMap<String, Object> loginInfo = null;
	      loginInfo = adminService.selectAdminLoginInfo(paramMap);
	      System.out.println(loginInfo);
	      
	      if(loginInfo != null) {
	         session.setAttribute("loginInfo", loginInfo);
	         return "redirect:/feed/mainPage.do";
	      } else {
	    	  return "redirect:/admin.do";      
	      }
	   }
	
	//main 화면
	@RequestMapping("/feed/mainPage.do")
	public String mainPage() {
		return "feed/mainPage";
	}	
	
	@RequestMapping("/feed/selectFeedList.do")
	public ModelAndView selectFeedList(@RequestParam HashMap<String, Object> paramMap, HttpSession session) {
	    ModelAndView mv = new ModelAndView();
	    
	    // 페이징 없이 이벤트 리스트를 가져옵니다.
	    HashMap<String, Object> sessionInfo = (HashMap<String, Object>) session.getAttribute("loginInfo");
	    paramMap.put("userId", sessionInfo.get("id").toString());
	    List<HashMap<String, Object>> list = adminService.selectFeedList(paramMap);
	    
	    mv.addObject("list", list);
	    mv.setViewName("jsonView");
	    return mv;
	}

	
	@RequestMapping("/feed/feedImgView.do")
	   public void feedImgView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	      String path = "C:/ictsaeil/insta/";
	      String fileName = request.getParameter("fileName").toString();
	        
	        File imageFile = new File(path, fileName);
	        
	        if (imageFile.exists()) {
	            response.setContentType("image/jpeg");
	            FileInputStream in = new FileInputStream(imageFile);
	            byte[] buffer = new byte[1024];
	            int bytesRead;
	            while ((bytesRead = in.read(buffer)) != -1) {
	                response.getOutputStream().write(buffer, 0, bytesRead);
	            }
	            in.close();
	        } else {
	            response.sendError(HttpServletResponse.SC_NOT_FOUND);
	        }
	    }  	
	
	@RequestMapping("/member/insertMember.do")
	public ModelAndView insertMember(@RequestParam HashMap<String, Object> paramMap) throws Exception{
		ModelAndView mv = new ModelAndView();
		String pwd = paramMap.get("userPw").toString();
		paramMap.replace("userPw", sha256.encrypt(pwd));

		
		int resultChk = 0;
		resultChk = adminService.insertMember(paramMap);

		
		mv.addObject("resultChk", resultChk);
		mv.setViewName("jsonView");
		return mv;
	}
	
	//피드 등록(저장)
	@RequestMapping("/feed/saveFeed.do")
	public ModelAndView saveFeed(@RequestParam HashMap<String, Object> paramMap, @RequestParam(name="fileList") List<MultipartFile> multipartFile
			, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		int resultChk = 0;
		
		HashMap<String, Object> sessionInfo = (HashMap<String, Object>) session.getAttribute("loginInfo");
		paramMap.put("userId", sessionInfo.get("id").toString());
		
		resultChk = adminService.saveFeed(paramMap, multipartFile);
		mv.addObject("resultChk", resultChk);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 피드 수정(상세)
	@RequestMapping("/feed/getfeedDetail.do")
	public ModelAndView getBoardDetail(@RequestParam(name = "feedIdx") int feedIdx) {
		ModelAndView mv = new ModelAndView();
		
		HashMap<String, Object> feedInfo = adminService.selectFeedDetail(feedIdx); //피드 수정 디테일
		List<HashMap<String, Object>> fileList = adminService.selectFileList(feedIdx);
		mv.addObject("fileList", fileList);
		mv.addObject("feedInfo", feedInfo);
		mv.setViewName("jsonView");
		return mv;
		}
	
	//파일 저장
	@RequestMapping("/feed/saveFeedComment.do")
	   public ModelAndView saveComment(
		         @RequestParam HashMap<String, Object> paramMap, HttpSession session) {
		      ModelAndView mv = new ModelAndView();
		      
		      HashMap<String, Object> sessionInfo = (HashMap<String, Object>) session.getAttribute("loginInfo");
		      // sessionInfo -> session에 있는 로그인정보 (loginInfo)를 가져옴
		      paramMap.put("userId", sessionInfo.get("id").toString());
		      // paramMap -> boardIdx, replyContent의 값이 들어가있음
		      int resultChk = 0;
		
		      resultChk = adminService.saveComment(paramMap);
		      
		      mv.addObject("resultChk", resultChk);
		      mv.setViewName("jsonView");
		      return mv;
	}
	
	//피드 삭제
	@RequestMapping("/feed/deleteFeed.do")
	public ModelAndView deleteFeed(@RequestParam HashMap<String, Object> paramMap
			, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		int resultChk = 0;
		
		HashMap<String, Object> sessionInfo = (HashMap<String, Object>) session.getAttribute("loginInfo");
		paramMap.put("userId", sessionInfo.get("id").toString());

		resultChk = adminService.deleteFeed(paramMap);
		
		mv.addObject("resultChk", resultChk);
		mv.setViewName("jsonView");
		return mv;
	}
	
	//댓글 삭제
	@RequestMapping("/feed/deleteFeedComment.do")
	   public ModelAndView deleteFeedComment(@RequestParam HashMap<String, Object> paramMap, HttpSession session) {
	      ModelAndView mv = new ModelAndView();
	      
	      HashMap<String, Object> sessionInfo = (HashMap<String, Object>) session.getAttribute("loginInfo");
	      paramMap.put("userId", sessionInfo.get("id").toString());
	      
	      int resultChk = 0;
	      
	      resultChk = adminService.deleteFeedComment(paramMap);
	      
	      mv.addObject("resultChk", resultChk);
	      mv.setViewName("jsonView");
	      return mv;
	   }
	
	// 좋아요 기능 구현
	@RequestMapping("/feed/feedLike.do")
	public ModelAndView insertFeedLike(@RequestParam HashMap<String, Object> paramMap, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		int resultChk = 0;

		HashMap<String, Object> sessionInfo = (HashMap<String, Object>) session.getAttribute("loginInfo");
		paramMap.put("userId", sessionInfo.get("id").toString());
		paramMap.put("userIdx", sessionInfo.get("userIdx").toString());

		resultChk = adminService.insertFeedLike(paramMap);

		mv.addObject("resultChk", resultChk);
		mv.setViewName("jsonView");
		return mv;
	}
}
