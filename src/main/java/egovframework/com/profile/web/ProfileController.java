package egovframework.com.profile.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.profile.service.ProfileService;

@Controller
public class ProfileController {

	//ProfileController
	//SHA256 sha256 = new SHA256();
	
	@Resource(name="ProfileService")
	private ProfileService profileService;
	
	//프로필 화면
	@RequestMapping("/mypage.do")
	public String mypage(HttpSession session, Model model) {
		// 로그인 정보를 세션에서 가져옴
		HashMap<String, Object> loginInfo = (HashMap<String, Object>) session.getAttribute("loginInfo");

		// 로그인 정보가 존재하는지 확인
		if (loginInfo != null) {
			// 로그인 정보가 있을 경우, 필요한 데이터를 모델에 추가
			model.addAttribute("loginInfo", loginInfo);
			System.out.println("프로필 페이지로 이동합니다.");
			// 추가적인 사용자 정보가 필요하다면 서비스 호출
			// 예: UserProfile profile = profileService.getUserProfile(loginInfo.get("id"));
			// model.addAttribute("profile", profile);			
			return "/feed/myPage";
		} else {
			// 로그인 정보가 없을 경우, 로그인 페이지로 리다이렉트
			return "redirect:/admin.do";
		}
	}
		
}
