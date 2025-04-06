<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml2/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
<title>오라클 출결관리</title>
<script src="./present.js"></script>
<link rel="apple-touch-icon" href="../images/naversmartlens.png">
<link rel="icon" type="image/png" href="../images/naversmartlens.png">
<link href="/worknet/css/intro/style.css?v201803001" rel="stylesheet">
<link href="/worknet/css/intro/widget_style.css?v201804010002" rel="stylesheet">
<!-- ================== BEGIN BASE CSS STYLE ================== -->
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
<link href="http://lms.atosoft.kr/worknet/assets/plugins/jquery-ui/themes/base/minified/jquery-ui.min.css" rel="stylesheet" />
<link href="http://lms.atosoft.kr/worknet/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<link href="http://lms.atosoft.kr/worknet/assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
<link href="../assets/css/animate.min.css" rel="stylesheet" />
<link href="../assets/css/style_student.css?v201803001" rel="stylesheet" />
<link href="../assets/css/style-responsive.min.css" rel="stylesheet" />
<link href="../assets/css/theme/default.css" rel="stylesheet" id="theme" />
<!-- ================== END BASE CSS STYLE ================== -->


<!-- ================== BEGIN BASE JS ================== -->
<script src="http://lms.atosoft.kr/worknet/assets/plugins/jquery/jquery-1.9.1.min.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/pace/pace.min.js"></script>
<!-- ================== END BASE JS ================== -->


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/jquery-cookie/jquery.cookie.js"></script>
<!-- ================== END BASE JS ================== -->

<!-- ================== BEGIN PAGE LEVEL JS ================== -->
<script src="http://lms.atosoft.kr/worknet/assets/plugins/gritter/js/jquery.gritter.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/flot/jquery.flot.min.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/flot/jquery.flot.time.min.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/flot/jquery.flot.resize.min.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/flot/jquery.flot.pie.min.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/sparkline/jquery.sparkline.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/jquery-jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/jquery-jvectormap/jquery-jvectormap-world-mill-en.js"></script>

<script src="http://lms.atosoft.kr/worknet/assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js" ></script>
<script src="http://lms.atosoft.kr/worknet/assets/plugins/bootstrap-datepicker/js/locales/bootstrap-datepicker.kr.js" ></script>
<script src="../js/sec.js?v=20190225"></script>

</head>
<body  class="gray-bg">
	<div id="content" class="row" style="margin:0px;">
		<div class="col-xs-12" style="margin:0px;">

		  <table border="0" align="center" style="width:100%;margin-top:10px;">
			 <tr>
			  <td align="left" width="50%"> 
				<h1><a href="http://oracle.atosoft.net/"><img src="../images/vendor_logo.png" width="90%"></a></h1>
			  </td>
			  <td align="right" width="50%"> 
				<h1><a href="http://oracle.atosoft.net/"><img src="../images/vendor_logo1.png" width="90%"></a></h1>
			  </td>
			 </tr>
			<!-- <tr>
				<td valign="top" style="padding:15px">
		  			 <div style="padding-top:20px">
		  				<img src="images/lms_main_intro.jpg" style="max-width:100%">
					 </div>
				</td>
				</tr>-->
				 <tr>
				<td valign="top" style="padding:15px" colspan="2">
				 <form class="form-horizontal" method="post" data-parsley-validate="true"  id="PresentStu" name="PresentStu">
					<input type="hidden" name="strCode" value="">
					<input type="hidden" name="strCCode" value="">
						<div class="login-layout">
							<h2>수강생 출결관리</h2>
								 <div class="login-form" id="strHere">
									<div> 
										<table border="0" width="100%">
											<tr>
												<th height="35">수강생 :</th>
												<th><div id="strNameHere"></div></th>
											</tr>
											<tr>
												<th height="35">과정명 :</th>
												<th><div id="strCNameHere"></div></th>
											</tr>
											<tr>
												<th height="35">출결일 :</th>
												<th>2025-03-24</th>
											</tr>
											
										</table>
									</div>
									
									<div class="login-btn" style="margin-top:10px;display:block;" id="present_on1">
										
									</div>

									<div class="login-btn" style="margin-top:10px;display:none;" id="present_on2">
										
									</div>

									

								</div>
								
							</div>
							<div class="login-bottom" id="ipzone"></div>
						</form><br>
						<!--<div id="plist1"></div><br>//-->
						<div id="plist"></div>
						
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<center><a style="cursor:pointer;" onclick="window.close();"  class="btn btn-sm btn-success">홈으로</a></center>
					<div class="copyright" align="center">
						<p class="m-t">Copyright &copy; 오라클  All Rights Reserved.</p>
					</div>
				</td>
			</tr>
		</table>
		
  </div>
</div>
<script language="javascript">

	history.pushState(null, null, location.href);
	window.onpopstate = function () {
		//if (confirm("뒤로가기 버튼을 클릭하면 로그아웃됩니다. 진행하시겠습니까?")){
			history.go(1);
		//}else{
		//	history.go(1);
		//}
	};

	var IPchk = 0;
	function goCookieChk(){
		var strCode  = "U202502060009";
		var strCCode = "W250121001";
		var strName  = "김건희";

		if (strCode == null){
			//document.getElementById('strHere').innerHTML = "<font color=red><b>인증절차를 진행한후 사용해주세요. 관리자에게 문의바랍니다.</b></font>";
			$('strHere').html("<font color=red><b>인증절차를 진행한후 사용해주세요. 관리자에게 문의바랍니다.</b></font>");
		}else{
			if (IPchk == 0){
				//alert("교육기관 wifi에 연결이 안되었습니다. wifi에 연결한 후 다시 사용하세요.");
				//document.getElementById('strHere').innerHTML = "<font color=red><b>교육기관 wifi에 연결이 안되었습니다.<br>wifi에 연결한 후 다시 사용하세요.</b></font>";
				$('strHere').html("<font color=red><b>교육기관 wifi에 연결이 안되었습니다.<br>wifi에 연결한 후 다시 사용하세요.</b></font>");
			}
			//document.getElementById('strNameHere').innerHTML = strName;		
			$('#strNameHere').html(strName);
			document.PresentStu.strCode.value = strCode;
			document.PresentStu.strCCode.value = strCCode;
			getStrCName(strCode,strCCode);
			getPresentList();
		}
	}

	function goInClass(){
		var strCodeI  = document.PresentStu.strCode.value;
		var strCCodeI = document.PresentStu.strCCode.value;
		var url = "PresentIn_ok.asp";
		var parm = "strCode="+strCodeI+"&strCCode="+strCCodeI;
					
		$.get(url,parm,function(data){
			if (data == 0){
				alert("교육기관 wifi내에서 입실버튼을 클릭해야합니다.\n교육기관 wifi내에서 다시 시도해주세요.")
			}else if(data == 2){
				alert("수업일이 아닙니다. 입실하실수 없습니다.");
			}
			location.reload(); 
		}, "html");
	}

	function goOutClass(){
		if(confirm("정말로 퇴실 하시겠습니까?")){	
			var strCodeO  = document.PresentStu.strCode.value;
			var strCCodeO = document.PresentStu.strCCode.value;
			var url = "PresentOut_ok.asp";
			var parm = "strCode="+strCodeO+"&strCCode="+strCCodeO;
						
			$.get(url,parm,function(data){
				//alert("정상적으로 퇴실처리가 완료되었습니다.");
				if (data == 0){
					alert("교육기관 wifi내에서 퇴실버튼을 클릭해야합니다.\n교육기관 wifi내에서 다시 시도해주세요.");
				}
				location.reload(); 
			}, "html");
		}
	}

	function goPeriodChk(strCode1,strCCode1){
		var url = "PresentPeriodChk.asp";
		var parm = "strCCode="+strCCode1;
					
		$.get(url,parm,function(data){
			if (data == 0){
				//document.getElementById('present_on1').innerHTML = "<font color=red><b>강의가 진행중인 과정이 아닙니다. 관리자에게 문의바랍니다.</b></font>";
				$('#present_on1').html("<font color=red><b>강의가 진행중인 과정이 아닙니다. 관리자에게 문의바랍니다.</b></font>");
				document.getElementById('present_on2').style.display = "none";
			}else{
				getRollBook(strCode1,strCCode1);
			}
		}, "html");
	}

	function getStrCName(strCode1,strCCode1){
		var url = "PresentStrCName.asp";
		var parm = "strCCode="+strCCode1;
					
		$.get(url,parm,function(data){
			//document.getElementById('strCNameHere').innerHTML = data;
			$('#strCNameHere').html(data);
			goPeriodChk(strCode1,strCCode1);
		}, "html");
	}

	function getPresentList(){
		var strCode  = "U202502060009";
		var strCCode = "W250121001";
		var url = "PresentRollBooklist.asp";
		var parm = "strCCode="+strCCode+"&strCode="+strCode;
					
		$.get(url,parm,function(data){
			//document.getElementById('plist').innerHTML = data;
			$('#plist').html(data);
		}, "html");
	}

	function getPresentList1(){
		var strCode  = "U202502060009";
		var strCCode = "W250121001";
		var url = "PresentRollBooklist1.asp";
		var parm = "strCCode="+strCCode+"&strCode="+strCode;
					
		$.get(url,parm,function(data){
			//document.getElementById('plist1').innerHTML = data;
			$('#plist1').html(data);
		}, "html");
	}

	function getRollBook(strCode1,strCCode1){
		var url = "PresentRollBookChk.asp";
		var parm = "strCCode="+strCCode1+"&strCode="+strCode1;
		
		$.get(url,parm,function(data){
			if (data != ""){
				data1 = data.split("|");
				if (data1[0] != null && data1[0] != '' && data1[1] != null && data1[1] != ''){
					//document.getElementById('present_on1').innerHTML = "<input type='button' value='입실시간 : "+ data1[0] +"' class='btn btn-primary block full-width' style='height:50px;font-size:20px;' />";	
					$('#present_on1').html("<input type='button' value='입실시간 : "+ data1[0] +"' class='btn btn-primary block full-width' style='height:50px;font-size:20px;' />");
					document.getElementById('present_on2').style.display = "block";
					//document.getElementById('present_on2').innerHTML = "<input type='button' value='퇴실시간 : "+ data1[1] +"' class='btn btn-warning block full-width' style='height:50px;font-size:20px;' />";
					$('#present_on2').html("<input type='button' value='퇴실시간 : "+ data1[1] +"' class='btn btn-warning block full-width' style='height:50px;font-size:20px;' />");
				}else if (data1[0] != null && data1[0] != '' && (data1[1] == null || data1[1] == '')){
					//document.getElementById('present_on1').innerHTML = "<input type='button' value='입실시간 : "+ data1[0] +"' class='btn btn-primary block full-width' style='height:50px;font-size:20px;' />" ;
					$('#present_on1').html("<input type='button' value='입실시간 : "+ data1[0] +"' class='btn btn-primary block full-width' style='height:50px;font-size:20px;' />");
					document.getElementById('present_on2').style.display = "block";
					//document.getElementById('present_on2').innerHTML = "<input type='button' value='퇴실' class='btn btn-warning block full-width' style='cursor:pointer;height:50px;font-size:20px;' onclick='goOutClass();'/>";
					$('#present_on2').html("<input type='button' value='퇴실' class='btn btn-warning block full-width' style='cursor:pointer;height:50px;font-size:20px;' onclick='goOutClass();'/>");
				}else if ((data1[0] == null || data1[0] == '') && data1[1] != null && data1[1] != ''){
					//document.getElementById('present_on1').innerHTML = "<input type='button' value='입실' class='btn btn-primary block full-width' style='cursor:pointer;height:50px;font-size:20px;' onclick='goInClass();' />";
					$('#present_on1').html("<input type='button' value='입실' class='btn btn-primary block full-width' style='cursor:pointer;height:50px;font-size:20px;' onclick='goInClass();' />");
					document.getElementById('present_on2').style.display = "block";
					document.getElementById('present_on2').innerHTML = data1[1];
				}else if(data1[0] == null || data1[0] == '') {
					//document.getElementById('present_on1').innerHTML = "<input type='button' value='입실' class='btn btn-primary block full-width' style='cursor:pointer;height:50px;font-size:20px;' onclick='goInClass();' />";
					$('#present_on1').html("<input type='button' value='입실' class='btn btn-primary block full-width' style='cursor:pointer;height:50px;font-size:20px;' onclick='goInClass();' />");
					document.getElementById('present_on2').style.display = "none";
				}
			}else{
				//document.getElementById('present_on1').innerHTML = "<input type='button' value='입실' class='btn btn-primary block full-width' style='cursor:pointer;height:50px;font-size:20px;' onclick='goInClass();' />";
				$('#present_on1').html("<input type='button' value='입실' class='btn btn-primary block full-width' style='cursor:pointer;height:50px;font-size:20px;' onclick='goInClass();' />");
				document.getElementById('present_on2').style.display = "none";
			}
		}, "html");
	}

	function getIP(){
		var url = "PresentIP.asp";
		var parm = "";
					
		$.get(url,parm,function(data){
			IPchk = data;		
			goCookieChk();
		}, "html");
		
	}
	getIP();

	// 뒤로 가기 방지 스크립트
	function preventBack() {
		window.history.pushState(null, "", window.location.href);
		window.onpopstate = function() {
			window.history.pushState(null, "", window.location.href);
		};
	}

	// 새로고침 방지 스크립트
	function preventRefresh(event) {
		if (event.keyCode === 116 || (event.ctrlKey && event.keyCode === 82)) {
			event.preventDefault();
			event.keyCode = 0;
			return false;
		}
	}

	// 페이지 로드 시 스크립트 실행
	window.onload = function() {
		preventBack();
		document.addEventListener("keydown", preventRefresh);
	};
	//getPresentList1();
	/*
	var timer = setInterval(function(){
       location.reload(); 
    }, 60000)
	*/
</script>
</body>
</html>
