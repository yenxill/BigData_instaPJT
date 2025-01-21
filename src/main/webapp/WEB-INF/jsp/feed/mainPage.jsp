<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- favicon -->
<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png"/>
<link rel="icon" type="image/png" sizes="32x32" href="/images/egovframework/favicon/favicon-32x32.png"/>
<link rel="icon" type="image/png" sizes="16x16" href="/images/egovframework/favicon/favicon-16x16.png"/>
<!-- 부트스트랩 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<!--    구글 머터리얼 아이콘   -->
<link href="https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.sandbox.google.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200"/>

<title>Instagram | Main</title>

<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/522c2b7a73.js" crossorigin="anonymous"></script>

<link rel="stylesheet" href="/css/egovframework/reset.css">
<link rel="stylesheet" href="/css/egovframework/color.css">
<link rel="stylesheet" href="/css/egovframework/usericon.css">
<link rel="stylesheet" href="/css/egovframework/mainStyle.css">

<script src="/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">	
/* 파일 업로드 관련 변수 */
var fileCnt = 0;
var totalCnt = 20;
var fileNum = 0;
var content_files = new Array();
var deleteFiles = new Array();
/* 파일 업로드 관련 변수 */

	$(document).ready(function () {
	    fn_selectList(1);
	
	    // 로그아웃
	    $("#btn_logout").on('click', function(){
	        fn_logout();
	    });
	
	    // 등록 버튼
	    $("#btn_insert").on('click', function(){
	        fn_save();
	    });
	
	    // 피드 수정 버튼
	    $("#btn_update").on('click', function(){
	        $("#statusFlag").val("U");
	        fn_save();
	    });
	
	    // 포스트 이미지 추가
	    $("#postImg").on("click", function(){
	        $("#uploadFile").click();
	    });
	
	    // 피드 삭제 버튼
	    $("#btn_delete").on('click', function(){
	        fn_delete();
	    });
	
	    // 포스트 업로드 버튼
	    $(".post-upload-btn").on("click", function(){
	        let postIconBox = document.querySelector('.postIconBox');
	        postIconBox.style.display = 'block';
	        $(".upload-wrapper").addClass("active");
	        fn_init();
	    });
	
	    // 해시태그 검색
	    $("#btn_search").on('click', function(){
	        fn_selectList();
	    });
	
	    // 사용자 아이콘 클릭 시 이벤트
	    $(".user-icon").on("click", function(){
	        let profilePopup = document.getElementById('profilePopup');
	        let overlay = document.getElementById('overlay');
	
	        // 팝업과 오버레이 표시
	        profilePopup.style.display = 'block';
	        overlay.style.display = 'block';
	    });
	
	    // 오버레이 클릭 시 팝업과 오버레이 닫기
	    $("#overlay").on("click", function (){
	        let profilePopup = document.getElementById('profilePopup');
	        let overlay = document.getElementById('overlay');
	
	        // 팝업과 오버레이 숨기기
	        profilePopup.style.display = 'none';
	        overlay.style.display = 'none';
	    });
	
	    // 피드 등록 상태 확인
	    var flag = "${flag}";
	    if (flag === "U") {
	        fn_updateFeed("${feedIdx}");
	    }
	
	    // 파일 업로드 
	    $("#file-upload-btn").on("change", function(e){
	        var files = e.target.files;
	     	// 파일 배열 담기
	        var filesArr = Array.prototype.slice.call(files);
	
	        // 파일 개수 확인 및 제한
	        if (fileCnt + filesArr.length > totalCnt){
	            alert("파일은 최대 " + totCnt + "개까지 업로드 할 수 있습니다.");
	            return;
	        } else {
	            fileCnt = fileCnt + filesArr.length;
	        }
	
	        // 각각의 파일 배열 담기 및 기타 처리
	        filesArr.forEach(function(f){
	            var reader = new FileReader();
	            reader.onload = function (e) {
	            	// 선택한 파일을 content_files 배열에 push
	                content_files.push(f);
	              	//console.log(f);
	                $("#boardFileList").append(
	                		'<div id="file'+fileNum+'" style="float:left;">'
							 +'<font style="font-size:12px">'
		                     +'<a href="javascript:fn_imgView(\''+fileNum+'\', \'I\');">'
		                     + f.name
		                     + '</a></font>'
		                     +'<a href="javascript:fileDelete(\'file'+fileNum+'\',\'\')">X</a>'
		                     +'</div>'
	                );
	                fileNum++;
	            };
	            let postIconBox = document.querySelector('.postIconBox');
	            postIconBox.style.display = 'none';
	
	            reader.readAsDataURL(f);
	        });
	
	        // 초기화
	        $("#file-upload-btn").val("");
	    });
	});	
	
	// 프로필
	function fn_mypage() {
	    location.href = '/mypage.do';
	}

	// 로그아웃
	function fn_logout() {
	    var frm = $("#logoutFrm");
	    frm.attr("method", "POST");
	    frm.attr("action", "/logout.do");
	    frm.submit();
	}

	// 해시태그 검색 enter로 검색 가능
	function searchFunction() {
	    const keyword = document.getElementById("searchKeyword").value;
	    if (keyword.trim() === "") {
	        alert("검색어를 입력하세요.");
	        return false;
	    }
	    // 여기에 실제 검색 로직을 추가합니다.
	    console.log("검색어:", keyword);
	    return false; // 폼 제출을 방지합니다.
	}

	function checkEnter(event) {
	    if (event.key === "Enter") {
	        event.preventDefault(); // 기본 Enter 동작 방지
	        searchFunction(); // 검색 함수 호출
	    }
	}
	
	/* 조회 */
	function fn_selectList() {
	    var frm = $("#searchFrm").serialize();
	    $.ajax({
	        url: '/feed/selectFeedList.do',
	        method: 'post',
	        data: frm,
	        dataType: 'json',
	        success: function(data, status, xhr) {
	        	//console.log(data.list);
	        	//console.log(음표);
	        	
	            var boardHtml = '';
	            if (data.list.length > 0) {
	                for (var i = 0; i < data.list.length; i++) {
	                    boardHtml += '<li class="post-item">';
	                    boardHtml += '<div class="profile">';
	                    boardHtml += '<div class="profile-img">';
	                    boardHtml += '<img src="/images/egovframework/photo/짱구.jpg" alt="프로필이미지" onclick="fn_mypage()">';
	                    boardHtml += '</div>';
	                    boardHtml += '<div class="profile-txt">';
	                    boardHtml += '<div class="username">' + data.list[i].createId + '</div>';
	                    boardHtml += '<div class="location">Sejong, South Korea</div>';
	                    boardHtml += '</div>';

	                    // 더보기 버튼 2가지 방식 처리
	                    var loginId = "${loginInfo.id}"; // 로그인한 사용자 ID
	                    var createId = data.list[i].createId; // 게시물 작성자 ID
	                    
	                    if (loginId === createId) {
	                        boardHtml += '<button class="option-btn" type="button" onclick="fn_moreOptionTrue(\'' + data.list[i].feedIdx + '\');">';
	                    } else {
	                        boardHtml += '<button class="option-btn" type="button" onclick="fn_moreOptionFalse(\'' + data.list[i].feedIdx + '\');">';
	                    }
	                    
	                    boardHtml += '<i class="fa-solid fa-ellipsis" aria-hidden="true"></i>';
	                    boardHtml += '</button>';
	                    boardHtml += '</div>'; // profile

	                    
	                    boardHtml += '<div id="carouselExampleControlsNoTouching_' + i + '" class="carousel slide" data-bs-touch="false" data-bs-interval="false" style="height: 600px;">';
	                    boardHtml += '<div class="carousel-inner">';
	                    
	                    for (var j = 0; j < data.list[i].fileList.length; j++) {
	                        boardHtml += '<div class="carousel-item' + (j === 0 ? ' active' : '') + '">';
	                        boardHtml += '<img src="/feed/feedImgView.do?fileName=' + data.list[i].fileList[j].saveFileName + '" class="d-block w-100 feed-picture" alt="...">';
	                        boardHtml += '</div>';
	                    }
	                    boardHtml += '</div>'; // carousel-inner
	                    if (data.list[i].fileList.length > 1) { // 업로드 된 이미지가 1장이면 슬라이드 버튼 안보이게
	                        boardHtml += '<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControlsNoTouching_' + i + '" data-bs-slide="prev">';
	                        boardHtml += '<span class="carousel-control-prev-icon" aria-hidden="true"></span>';
	                        boardHtml += '<span class="visually-hidden">Previous</span>';
	                        boardHtml += '</button>';
	                        boardHtml += '<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControlsNoTouching_' + i + '" data-bs-slide="next">';
	                        boardHtml += '<span class="carousel-control-next-icon" aria-hidden="true"></span>';
	                        boardHtml += '<span class="visually-hidden">Next</span>';
	                        boardHtml += '</button>';
	                    }
	                    boardHtml += '  </div>'; // carousel

	                    // 좋아요, 댓글, 저장 아이콘
	                    boardHtml += '<div class="post-icons">';
	                    boardHtml += '<div>';
	                    
	                 	// 좋아요 상태에 대한 style
	                    if (data.list[i].likeYn === 'N') {
	                        boardHtml += '<span class="post-heart" onclick="fn_feedLike(\'' + data.list[i].feedIdx + '\',\'I\');">';
	                        boardHtml += '<i class="fa-regular fa-heart" aria-hidden="true"></i>';
	                        boardHtml += '</span>';
	                    } else {
	                        boardHtml += '<span class="post-heart active" style="color: tomato;" onclick="fn_feedLike(\'' + data.list[i].feedIdx + '\',\'U\');">';
	                        boardHtml += '<i class="fa-solid fa-heart" aria-hidden="true"></i>';
	                        boardHtml += '</span>';
	                    }
	                    boardHtml += '<span><i class="fa-regular fa-comment" aria-hidden="true"></i></span>';
	                    boardHtml += '</div>';
	                    boardHtml += '<span><i class="fa-regular fa-bookmark" aria-hidden="true"></i></span>';
	                    boardHtml += '</div>'; // post-icons

	                    // 좋아요 수
	                    boardHtml += '<div class="post-likes">';
	                    boardHtml += '좋아요 <span id="like-count">' + data.list[i].likeCount + '</span> 개';
	                    boardHtml += '</div>'; // post-likes

	                    // 게시물 내용
	                    boardHtml += '<div class="post-content">';
	                    boardHtml += '<p style="font-size:13px;padding:10px;" id="feed-count">' + data.list[i].feedContent + '</p>';
	                    boardHtml += '</div>'; // post-content

	                    // 해시태그
	                    boardHtml += '<div class="post_hashtag">';
	                    boardHtml += '<span style="font-size:12px; font-weight: lighter; color: dodgerblue; padding:10px;" id="feed_hashtag">' + data.list[i].feedHashtag + '</span>';
	                    boardHtml += '</div>'; // post-hashtag

	                    // 댓글 목록
	                    boardHtml += '<div class="comment-list">';
	                    for (var k = 0; k < data.list[i].commentList.length; k++) {
	                    	boardHtml += '<div class="comment-list">';
	                        boardHtml += '<div class="comment" id="comment_' + data.list[i].commentList[k].commentIdx + '">';
	                        boardHtml += '<div class="comment-detail">';
	                        boardHtml += '<div class="username">' + data.list[i].commentList[k].createId + '</div>';
	                        boardHtml += '<p style="margin-bottom: 0;">' + data.list[i].commentList[k].commentContent + '</p>';
	                        boardHtml += '</div>';
	                        boardHtml += '<div style="display: flex; align-items: center;">';
	                        
	                        if (data.list[i].commentList[k].createId === "${loginInfo.id}") {
	                            boardHtml += '<a href="javascript:fn_commentDelete(\''+data.list[i].commentList[k].commentIdx+'\');" class="comment-delete">';
	                            boardHtml += '삭제';
	                            boardHtml += '</a>';
	                        }
	                        boardHtml += '<div class="comment-heart"><i class="fa-regular fa-heart"></i></div>';
	                        boardHtml += '</div>';
	                        boardHtml += '</div>'; // comment
	                    }
	                    boardHtml += '</div>'; // comment-list
	                    
	                    boardHtml += '<div class="timer">' + data.list[i].timeDiffer+ ' 전' + '</div>';

	                    // 댓글 입력
	                    boardHtml += '<div class="comment-input">';
	                    boardHtml += '<input type="text" placeholder="댓글달기..." id="commentContent_' + data.list[i].feedIdx + '">';
	                    boardHtml += '<button class="upload_btn" type="button" onclick="fn_savecomment(' + data.list[i].feedIdx + ');">게시</button>';
	                    boardHtml += '</div>'; // comment-input
	                    boardHtml += '</li>'; // post-item
	                }
	            } else {
	                boardHtml += '<li class="post-item" style="text-align:center;">등록된 글이 없습니다.</li>';
	            }

	            $(".post-list").html(boardHtml); // class selector로 HTML 삽입
	        },
	        error: function(data, status, err) {
	            console.log(err);
	        }
	    });
	}
	
	// 더보기 메뉴 함수 생성(로그인 아이디가 보여지는 더보기)
	function fn_moreOptionTrue(feedIdx) {
	    //console.log(feedIdx);

	    $(".more-option").addClass("active");
	    var moreHtml = '';

	    moreHtml += '<ul>';
	    moreHtml += '<li onclick="javascript:fn_delete(\'' + feedIdx + '\');" class="red-txt">삭제</li>';
	    moreHtml += '<li onclick="javascript:fn_updateFeed(\'' + feedIdx + '\');">수정</li>';
	    moreHtml += '<li>다른 사람에게 좋아요 수 숨기기</li>';
	    moreHtml += '<li>댓글 기능 해제</li>';
	    moreHtml += '<li>게시물로 이동</li>';
	    moreHtml += '<li>공유 대상...</li>';
	    moreHtml += '<li>링크 복사</li>';
	    moreHtml += '<li>퍼가기</li>';
	    moreHtml += '<li class="option-close-btn" onclick="fn_popupClose();">취소</li>';
	    moreHtml += '</ul>';

	    $("#moreOption").html(moreHtml);
	}

	function fn_popupClose() {
	    $(".more-option").removeClass("active");
	}

	// 더보기 메뉴 함수 생성(로그인한 아이디가 아닐 경우)
	function fn_moreOptionFalse(feedIdx) {
	    //console.log(feedIdx);

	    $(".more-option").addClass("active");
	    var moreHtml = '';

	    // 다른 사람이 로그인하면 메뉴가 다르게 보이게 처리
	    moreHtml += '<ul>';
	    moreHtml += '<li>팔로우 취소</li>';
	    moreHtml += '<li>게시물로 이동</li>';
	    moreHtml += '<li>공유 대상...</li>';
	    moreHtml += '<li>링크 복사</li>';
	    moreHtml += '<li>퍼가기</li>';
	    moreHtml += '<li>이 계정 정보</li>';
	    moreHtml += '<li class="option-close-btn" onclick="fn_popupClose();">취소</li>';
	    moreHtml += '</ul>';

	    $("#moreOption").html(moreHtml);
	}

	function fn_popupClose() {
	    $(".more-option").removeClass("active");
	}
	
	/* 피드 등록 및 수정 */
	function fn_save() {
	    /* 팝업 닫기 변수 */
	    var uploadPopup = document.querySelector('.upload-wrapper');
	    function popupOpen(item) {
	        item.classList.add('active');
	    }
	    function popupClose(item) {
	        item.classList.remove('active');
	    }

	    // var frm = $("#saveFrm").serialize();
	    var formData = new FormData($("#saveFrm")[0]);

	    for(var x = 0; x < content_files.length; x++) {
	        // 삭제 안 한 것만 담아준다.
	        if (!content_files[x].is_delete) {
	            formData.append("fileList", content_files[x]);
	        }
	    }

	    if(deleteFiles.length > 0) {
	        formData.append("deleteFiles", deleteFiles);
	    }

	    $.ajax({
	        url: '/feed/saveFeed.do',
	        method: 'post',
	        data: formData,
	        enctype: "multipart/form-data",
	        processData: false,
	        contentType: false,
	        dataType: 'json',
	        success: function (data, status, xhr) {
	            if (data.resultChk > 0) {
	                alert("저장되었습니다.");
	                popupClose(uploadPopup); // 팝업 닫기
	                fn_init();
	                fn_selectList(1); // 리스트 업데이트
	                content_files = new Array();
	                delete_files = new Array();
	            } else {
	                alert("저장에 실패하였습니다.");
	            }
	        },
	        error: function (data, status, err) {
	            console.log(err);
	        }
	    });
	}
	
	// 피드 삭제
	function fn_delete(feedIdx) {
	    $.ajax({
	        url: '/feed/deleteFeed.do',
	        method: 'post',
	        data: { "feedIdx": feedIdx },
	        dataType: 'json',
	        success: function (data, status, xhr) {
	            if (data.resultChk > 0) {
	                alert("삭제되었습니다.");
	                fn_popupClose();
	                fn_selectList(1);
	            } else {
	                alert("삭제에 실패하였습니다.");
	            }
	        },
	        error: function (data, status, err) {
	            console.log(err);
	        }
	    });
	}
	
	// 댓글 등록
	function fn_savecomment(feedIdx) {     
	    var commentContent = $("#commentContent_" + feedIdx).val();
	    //console.log(commentContent);
	    $.ajax({
	        url: '/feed/saveFeedComment.do',
	        method: 'post',
	        data: { 
	            "feedIdx": feedIdx,
	            "commentContent": commentContent
	        },
	        dataType: 'json',
	        success: function(data, status, xhr) {
	            if (data.resultChk > 0) {
	                alert("등록되었습니다.");
	                //fn_getReply(feedIdx); // 게시물 목록 보여주기
	                fn_selectList(1);
	                $("#commentContent").val(""); // 댓글 입력 필드 초기화
	            } else {
	                alert("등록에 실패하였습니다.");
	            }
	        },
	        error: function(data, status, err) {
	            console.log(status);
	        }
	    });
	}

	// 게시물 댓글 보여주기
	/* function fn_getReply(feedIdx) {
	    $.ajax({
	        url: '/main/feedViewComment.do', // 서버에 댓글 데이터를 요청하는 엔드포인트
	        method: 'post',
	        data: { "feedIdx": feedIdx },
	        dataType: 'json',
	        success: function(data, status, xhr) {
	            var commentHtml = '';

	            if (data.commentList && data.commentList.length > 0) {
	                // 서버로부터 받은 댓글 목록을 순회하며 HTML 구성
	                data.replyList.forEach(function(comment) {
	                    commentHtml += '<div class="comment-list">';
	                    commentHtml += '<div class="comment-username">' + data.list[i].commentList[k].userId + '</div>';
	                    commentHtml += '<div class="comment-content">' + data.list[i].commentList[k].commentContent + '</div>';
	                    commentHtml += '<div class="comment-date">' + data.list[i].commentList[k].createDate + '</div>';
	                    commentHtml += '</div>'; // comment-item
	                });

	                // 특정 피드 아이템에 댓글 목록을 업데이트
	                $('#feed_' + feedIdx + ' .comment-list').html(commentHtml);
	            } else {
	                // 댓글이 없을 경우 메시지 표시
	                $('#feed_' + feedIdx + ' .comment-list').html('<p>댓글이 없습니다.</p>');
	            }
	        },
	        error: function(data, status, err) {
	            console.log("댓글 불러오기 실패:", err);
	        }
	    });
	} */
	
	// 댓글 삭제
	function fn_commentDelete(commentIdx) {
	    if (confirm("삭제하시겠습니까?")) {
	        $.ajax({
	            url: '/feed/deleteFeedComment.do',
	            method: 'post',
	            data: { 
	                "commentIdx": commentIdx
	            },
	            dataType: 'json',
	            success: function(data, status, xhr) {
	                if (data.resultChk > 0) {
	                    alert("삭제되었습니다.");
	                    $("#comment_" + commentIdx).remove();
	                    fn_selectList(1);
	                } else {
	                    alert("삭제에 실패하였습니다.");
	                }
	            },
	            error: function(data, status, err) {
	                console.log(status);
	            }
	        });
	    }
	}
	
	// 피드 상세보기
	function fn_updateFeed(feedIdx) {
	    /* 팝업 닫기 변수 */
	    var uploadPopup = document.querySelector('.upload-wrapper');
	    uploadPopup.classList.add('active');
	    popupClose(uploadPopup); // 팝업 닫기

	    $("#statusFlag").val("U");
	    $("#feedIdx").val(feedIdx);

	    var formData = new FormData($("#saveFrm")[0]);

	    if ($("#statusFlag").val() === "U") {
	        $("#btn_insert").hide();
	        $("#btn_update").show();
	        $(".new_upload_tit").hide();
	        $(".update_upload_tit").show();
	    } else {
	        $("#btn_insert").show();
	        $("#btn_update").hide();
	        $(".new_upload_tit").show();
	        $(".update_upload_tit").hide();
	    }

	    fn_popupClose();
	    $(".upload-wrapper").addClass("active");

	    $.ajax({
	        url: '/feed/getfeedDetail.do',
	        method: 'post',
	        data: { "feedIdx": feedIdx },
	        dataType: 'json',
	        success: function (data, status, xhr) {
	            $("#feedContent").val(data.feedInfo.feedContent);
	            $("#feedHashtag").val(data.feedInfo.feedHashtag);

	            var innerHtml = '';
	            var imgHtml = '';
	            let canvas = document.getElementById('img-canvas');
	            let ctx = canvas.getContext('2d');
	            let postIconBox = document.querySelector('.postIconBox');
	            let img = new Image();

	            img.onload = function () {
	                canvas.width = 500;
	                canvas.height = 400;
	                ctx.drawImage(img, 0, 0, 500, 400);
	            };
	            postIconBox.style.display = 'none';

	            for (var i = 0; i < data.fileList.length; i++) {
	                // imgHtml += '<img src="/main/feedImgView.do?fileName=' + data.fileList[i].saveFileName + '" class="d-block w-100 feed-picture" alt="..."/>';
	                img.src = "/feed/feedImgView.do?fileName=" + data.fileList[i].saveFileName;

	                // 파일 삭제 버튼 소스 추가
	                innerHtml += '<div id="file' + i + '">' +
	                             '<font style="font-size:12px">' +
	                             '<a href="javascript:fn_imgView(\'' + data.fileList[i].saveFileName + '\', \'U\');">' + data.fileList[i].originalFileName + '</a></font>' +
	                             '<a href="javascript:fileDelete(\'file' + i + '\', \'' + data.fileList[i].fileIdx + '\');">X</a>' +
	                             '</div>';
	            }

	            $("#boardFileList").html(innerHtml);
	        },
	        error: function (data, status, err) {
	            console.log(err);
	        }
	    });
	}
	
	// 첨부파일 삭제 기능
	function fileDelete(fileNum, fileIdx) {
	    var no = fileNum.replace(/[^0-9]/g, ""); // /[^0-9]/g 공백 제거 후 숫자로 변환 (정규식)

	    if (fileIdx != "") {
	        deleteFiles.push(fileIdx);
	    } else {
	        content_files[no].is_delete = true;
	    }
	    $("#" + fileNum).remove();
	    fileCnt--;
	}

	// 피드 초기화 (맨 하단 추가)
	function fn_init() {
	    // canvas
	    var cnvs = document.getElementById('img-canvas');
	    // context
	    var ctx = cnvs.getContext('2d');

	    // 픽셀 정리
	    ctx.clearRect(0, 0, cnvs.width, cnvs.height);
	    // 컨텍스트 리셋
	    ctx.beginPath();

	    $("#statusFlag").val("I");
	    $("#btn_insert").show();
	    $("#btn_update").hide();
	    $(".new_upload_tit").show();
	    $(".update_upload_tit").hide();

	    $("#uploadFile").val("");
	    $("#feedContent").val("");
	    $("#feedHashtag").val("");
	    $("#boardFileList").html("");

	    content_files = new Array();
	    delete_files = new Array();
	    fileNum = 0;
	    fileCnt = 0;
	}

	$(".upload-wrapper").removeClass("active");

	// fn_imgView (맨 하단 추가)
	function fn_imgView(fileName, type) {
	    console.log(fileName, type);

	    if (type == 'I') {
	        var reader = new FileReader();
	        var e = content_files[fileName];
	        var canvas = document.getElementById('img-canvas');
	        let ctx = canvas.getContext('2d');

	        reader.onload = function(e) {
	            var img = new Image();

	            img.onload = function() {
	                canvas.width = 500;
	                canvas.height = 300;
	                ctx.drawImage(img, 0, 0, 500, 300);
	            };
	            img.src = e.target.result;
	        };
	        reader.readAsDataURL(e);
	    } else {
	        let canvas = document.getElementById('img-canvas');
	        let ctx = canvas.getContext('2d');
	        let img = new Image();

	        img.onload = function() {
	            canvas.width = 500;
	            canvas.height = 400;
	            ctx.drawImage(img, 0, 0, 500, 400);
	        };
	        img.src = "/feed/feedImgView.do?fileName=" + fileName;
	    }
	}
	
	// 좋아요 기능
	function fn_feedLike(feedIdx, type) {
	    $.ajax({
	        url: '/feed/feedLike.do',
	        method: 'post',
	        data: {
	            "feedIdx": feedIdx,
	            "likeType": type // 파라미터 type
	        },
	        dataType: 'json',
	        success: function (data, status, xhr) {
	            if (data.resultChk > 0) {
	                if (type == 'I') {
	                    alert("좋아요 성공");
	                } else if (type == 'U') {
	                    alert("좋아요 취소");
	                }
	                fn_selectList(1);
	            } else {
	                alert("좋아요 실패");
	            }
	        },
	        error: function (data, status, err) {
	            console.log(status);
	        }
	    });
	}	
</script>
</head>

<body>
	<div class="wrapper">
		<header class="global-header">
			<div>
				<h1 class="logo">
					<a href="/feed/mainPage.do"> 
					<img src="/images/egovframework/photo/logo-light.png" alt="logo">
					</a>
				</h1>
				<form id="searchFrm" name="searchFrm" onsubmit="return searchFunction();">
					<input type="hidden" id="pageIndex" name="pageIndex" value="1" />
					
					<ul class="gnb-icon-list">
						<li><input type="text" id="searchKeyword" name="searchKeyword" class="txt" placeholder=" #해시태그" /></li>
						<!-- <li><i class="fa-solid fa-magnifying-glass search-icon"></i> <input type="button" id="btn_search" name="btn_search" value="" class="btn_blue_l" /></li> -->
						<li>
					        <button id="btn_search" name="btn_search" class="btn_blue_l" type="submit" onclick="searchFunction()">
					        	<i class="fa-solid fa-magnifying-glass search-icon"></i>
					        </button>
					    </li> 
					
						<li class="post-upload-btn"><i class="fa-regular fa-square-plus"></i></li>
						<li><i class="fa-regular fa-compass"></i></li>
						<!-- <li><i class="fa-regular fa-heart"></i></li>	 -->		
						<li class="user-icon"> <i class="fa-solid fa-user"></i></li>
              	 </ul>
            </form>
			</div>
		</header>
		
	<!-- 오버레이 -->
    <div id="overlay" class="overlay" style="display:none;"></div>

    <!-- 팝업 영역 -->
    <div id="profilePopup" class="profile-popup" style="display:none;">
        <div class="popup-content">
            <div class="img-area" onclick="fn_mypage()">
                <div class="inner-area">
                    <img src="/images/egovframework/photo/짱구.jpg">
                </div>
            </div>
            
            <div class="name">
            	${loginInfo.id}
            </div>
            
            <div class="buttons">
                <form id="logoutFrm" name="logoutFrm">
					<button id="btn_logout" name="btn_logout" class="btn_blue_l" type="button">
						<i class="fa-solid fa-power-off"></i>
					</button>
                </form>
            </div>           
        </div>
    </div>
		
		<main>
			<ul class="post-list">
			</ul>

			<div class="recommend lg-only">
				<div class="side-user">
					<div class="profile-img side">
						<a href=""> 
						<img src="/images/egovframework/photo/짱구.jpg" alt="프로필사진">
						</a>
					</div>

					<div>
						<div class="username">${loginInfo.id}</div>
						<div class="ko-name">${loginInfo.name}</div>
					</div>
				</div>

				<div class="recommend-list">
					<div class="reco-header">
						<p>회원님을 위한 추천</p>
						<button class="all-btn" type="button">모두 보기</button>
					</div>

					<div class="thumb-user-list">
						<div class="thumb-user">
							<div class="profile-img">
								<img src="/images/egovframework/photo/멍2.jpeg" alt="프로필사진">
							</div>
							<div>
								<div class="username">zzz_zzz</div>
								<p>instagram 신규 가입</p>
							</div>
						</div>

						<div class="thumb-user">
							<div class="profile-img">
								<img src="/images/egovframework/photo/멍3.jpeg" alt="프로필사진">
							</div>

							<div>
								<div class="username">lorem</div>
								<p>회원님을 위한 추천</p>
							</div>
						</div>

						<div class="thumb-user">
							<div class="profile-img">
								<img src="/images/egovframework/photo/user.jpeg" alt="프로필사진">
							</div>

							<div>
								<div class="username">cldieid</div>
								<p>회원님을 위한 추천</p>
							</div>
						</div>

						<div class="thumb-user">
							<div class="profile-img">
								<img src="/images/egovframework/photo/user.jpeg" alt="프로필사진">
							</div>

							<div>
								<div class="username">abcdefg</div>
								<p>회원님을 위한 추천</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</main>


		<div class="upload-wrapper">
			<button class="post-close-btn" type="button">
				<i class="fa-solid fa-xmark"></i>
			</button>

<!-- 피드 등록  -->
			<div class="post-upload">
			
				<!-- 피드 등록 시작 -->
				<form id="fileFrm" name="fileFrm" method="POST">
					<input type="hidden" id="fileName" name="fileName" value=""/>
					<input type="hidden" id="filePath" name="filePath" value=""/>
				</form>
				
				<form id="saveFrm" name="saveFrm" class="post_form" action="">
					<input type="hidden" id="statusFlag" name="statusFlag" value="I"/>
					<input type="hidden" id="feedIdx" name="feedIdx" value="${feedIdx}"/>
					
					<p class="new_upload_tit">새 게시물 만들기</p>
					<p class="update_upload_tit" style="display:none;">게시물 수정하기</p>

					<div id="postImg" class="post-img-preview">
						<div class="postIconBox">  
							<div class="plus_icon">
								<img src="/images/egovframework/photo/upload.png" alt="">
							</div>
						</div>
							<canvas id="img-canvas"></canvas>
					</div>

					<div class="post-file">
						<input id="file-upload-btn" type="file" name="file-upload-btn" required="required" multiple> <!-- style="display: none;" -->
						<div id="boardFileList"></div>
					</div>

					<p class="post-txt">
						<textarea name="feedContent" id="feedContent" cols="50" rows="5" placeholder="문구를 입력하세요..."></textarea>
					</p>
					
					<p class="post-txt">
                  		<textarea rows="1" cols="50" id="feedHashtag" name="feedHashtag" class="text" placeholder="#해시태그"></textarea>
               		</p>

					<button id="btn_insert" name="btn_insert" class="submit_btn btn-blue" type="submit">공유하기</button>
					<button style="display:none;" id="btn_update" name="btn_update" class="submit_btn btn-blue" type="button">수정하기</button>
				</form>
			</div>
		</div>
<!-- 피드 등록  끝 -->		

	<div class="more-option" id="moreOption" name="moreOption" >
			<!-- <ul>
				<li class="red-txt" id="btn_delete" name="btn_delete">삭제</li>
				<li>수정</li>
				<li>다른 사람에게 좋아요 수 숨기기</li>
				<li>댓글 기능 해제</li>
				<li>게시물로 이동</li>
				<li>공유 대상...</li>
				<li>링크 복사</li>
				<li>퍼가기</li>
				<li class="option-close-btn">취소</li>
			</ul> -->
		</div>
	</div>

	<script src="/js/main_scrip.js"></script>
<!-- Option 1: Bootstrap Bundle with Popper -->
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>

</body>
</html>