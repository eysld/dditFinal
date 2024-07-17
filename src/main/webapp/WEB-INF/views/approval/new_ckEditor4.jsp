<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.ckeditor.com/4.20.0/full-all/ckeditor.js"></script>
<title>Insert title here</title>
</head>
<body>
<div class="btn-compost-wrapper d-grid">
		<button class="btn btn-primary btn-compose " data-bs-toggle="modal"
			data-bs-target="#newApprovalModal" id="newApproval">결재 정보</button>
	</div>  
<table border="1">
	<tr>
		<td>제목</td>
		<td><input /></td>
	</tr>
</table>
<textarea id="content"></textarea>

<!-- Modal -->
<div class="modal fade" id="newApprovalModal" tabindex="-1" aria-labelledby="newApproval" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">결재 정보</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          </button>
      </div>
      <div class="modal-body">
      	 <ul class="nav nav-tabs tabs-line">
	    <li class="nav-item">
	      <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#tab-update">
	        <i class="ti ti-edit me-2"></i>
	        <span class="align-middle">결재선</span>
	      </button>
	    </li>
	    <li class="nav-item">
	      <button class="nav-link" data-bs-toggle="tab" data-bs-target="#tab-activity">
	        <i class="ti ti-trending-up me-2"></i>
	        <span class="align-middle">참조자</span>
	      </button>
	    </li>
	  </ul>
	  <div class="tab-content px-0 pb-0">
    	<input type="text" id="schName" value="">
		
		<!-- 전체 레이아웃을 가로로 배치하는 컨테이너 -->
		<div style="display: flex;">
		
		    <!-- jstree는 왼쪽에 배치 -->
		    <div id="jstree" style="flex: 1; max-width: 40%; padding-right: 20px; "></div>
		
		    <!-- 컨테이너는 jstree 오른쪽에 배치 -->
		    <div class="container" style="flex: 2; padding-left: 20px;">
	    	    <!-- 결재선 -->
			    <div class="tab-pane fade show active" id="tab-update" role="tabpanel">
			      <form>
					test
			      </form>
			    </div>
			    <!-- 참조자 -->
			      <div class="tab-pane fade" id="tab-activity" role="tabpanel">
			      	test
			      </div>
			    </div>
		        <!-- 상세 정보 표시 -->
<!-- 			        <div id="detail" style="padding-left: 20px;"></div> -->
		    </div>
		</div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<script>
const urlParams = new URL(location.href).searchParams;
const atCd= urlParams.get('atCd');

$(function(){
	CKEDITOR.replace("content", {
		extraPlugins: 'autogrow',
		autoGrow_minHeight: 200,
		autoGrow_maxHeight: 600,
		autoGrow_bottomSpace: 50,
		height: 'auto'
	});
	fetch("/approval/"+atCd)
		.then((resp)=>{
			resp.json().then((data)=>{
				console.log(data);
				CKEDITOR.instances.content.setData(data.atCn);
			})
		})
// 	console.log(atCd);
	
	
});

//껌색
let id = "";
let str = "";

function fSch() {
    console.log("껌색할께영");
    $('#jstree').jstree(true).search($("#schName").val());
}

$("#schName").on("input", function(){
    $('#jstree').jstree(true).search($("#schName").val());
    if($("#schName").val() == ""){
    	str = "";
        $("#detail").html(str);
    }
    
});

//중요 속성, original, icon, state
// root node는 parent를 #

//Default 설정 바꾸깅, 아래를 주석 처리해보면 모양이 어케 바뀔깡?
$.jstree.defaults.core.themes.variant = "large";


//일반적으로 요렇게만 사용해도 충분!
$("#jstree").jstree({
    "plugins": ["search"],
    'core': {
        'data': {
            "url": function (node) {
                return "/orgchart/select"; // ajax로 요청할 URL
            }
            /*,
            "data": function (node) {
                return { 'id': node.id }  // ajax로 보낼 데이터(없어서 주석)
            }
            */,
        },
        "check_callback": true,  // 요거이 없으면, create_node 안먹음
    }
});


//이벤트
$('#jstree').on("changed.jstree", function (e, data) {
    console.log(data.selected);
});

// Node 선택했을 땡
$('#jstree').on("select_node.jstree", function (e, data) {
    console.log("select했을땡", data.node);
    id = data.node.id;
    
    console.log("id : " + id);
    
    let dataId = {
			"id" : id	
	};
    
	console.log("dataId : ", dataId);
    
	$.ajax({
		url : "/orgchart/detail",
		contentType:"application/json;charset=utf-8",
		data :JSON.stringify(dataId),
		type :"post",
		dataType : "json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success:function(result){
			console.log("result : ", result);
			
		},
	    error: function (request, status, error) {
	        console.log("code: " + request.status)
	        console.log("message: " + request.responseText)
	        console.log("error: " + error);
	    }
	});
    
    
});
</script>
</body>
</html>