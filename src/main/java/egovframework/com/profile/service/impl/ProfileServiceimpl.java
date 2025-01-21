package egovframework.com.profile.service.impl;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.io.IOException;


import java.io.IOException;
import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.profile.service.ProfileService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("ProfileService")
public class ProfileServiceimpl extends EgovAbstractServiceImpl implements ProfileService{

	@Resource(name="ProfileDAO")
	private ProfileDAO profileDAO;
	
}
