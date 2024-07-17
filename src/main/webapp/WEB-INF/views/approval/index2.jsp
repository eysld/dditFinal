<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!-- Page CSS -->
<link rel="stylesheet" href="/resources/vuexy/assets/vendor/css/pages/app-email.css" />
<script type="text/javascript">
$(function(){
	getList();
})

function getList(){
	$.ajax({
		url:"/approval/getAllList",
		type:"get",
		success:function(result){
			console.log(result);
			let str = "";
			for(const approvalVO of result){
		        str += `
		        	<div>\${approvalVO.aprvrDocTtl}</div>
		        	<div>\${approvalVO.writer}</div>
		        	<div>\${approvalVO.strWrtYmd}</div>
		        	<div>\${approvalVO.atNm}</div>
		        `; 
		        if(approvalVO.aprvrEmgyn === 'Y'){
		        	str += `<div>긴급</div>`;
		        }
		        if(approvalVO.aprvrSttsCd === 'A07'){
		        	str += `<div>잔행중</div>`;
		        }else{
		        	str += `<div>반려</div>`;
		        }
		        for(const approvalLineVO of approvalVO.approvalLineList){
		        	str += `<div>\${approvalLineVO.approver}</div>`
		        }
		       str += ` <hr />`;
			}
			$('#test').html(str);
		}
	})
}
</script>
<div class="app-email card" id="approval">
  <div class="row g-0">
  
    <!-- Email Sidebar -->
    <div class="col app-email-sidebar border-end flex-grow-0" id="app-email-sidebar">
    
      <div class="btn-compost-wrapper d-grid">
        <button
          class="btn btn-primary btn-compose "
          data-bs-toggle="modal"
          data-bs-target="#newApprovalModal"
          id="newApproval">
                 새 결재
        </button>
      </div>
      
      <!-- 문서함 리스트 -->
      <div class="email-filters py-2 fnoto">
        <!-- Email Filters: Folder -->
      	<small class="fw-medium text-uppercase text-muted m-4">결재 상신함</small>
        <ul class="email-filter-folders list-unstyled mb-4 mt-2">
          <li class="active d-flex justify-content-between" data-target="inbox">
            <a href="javascript:void(0);" class="d-flex flex-wrap align-items-center">
              <i class="ti ti-ballpen ti-sm"></i>
              <span class="align-middle ms-2 fw-normal">결재진행</span>
            </a>
            <div class="badge bg-label-primary rounded-pill badge-center">4</div>
          </li>
          <li class="d-flex" data-target="sent">
            <a href="javascript:void(0);" class="d-flex flex-wrap align-items-center">
              <i class="ti ti-checkbox ti-sm"></i>
              <span class="align-middle ms-2 fw-normal">결재완료</span>
            </a>
          </li>
          <li class="d-flex" data-target="draft">
            <a href="javascript:void(0);" class="d-flex flex-wrap align-items-center">
              <i class="ti ti-file ti-sm"></i>
              <span class="align-middle ms-2 fw-normal">임시저장</span>
            </a>
          </li>
        </ul>
        <small class="fw-normal text-uppercase text-muted m-4">결재 수신함</small>
        <ul class="email-filter-folders list-unstyled mb-4 mt-2">
          <li class="d-flex justify-content-between" data-target="starred">
            <a href="javascript:void(0);" class="d-flex flex-wrap align-items-center">
              <i class="ti ti-alert-circle ti-sm"></i>
              <span class="align-middle ms-2 fw-normal">결재요청</span>
            </a>
            <div class="badge bg-label-warning rounded-pill badge-center">10</div>
          </li>
          <li class="d-flex align-items-center" data-target="spam">
            <a href="javascript:void(0);" class="d-flex flex-wrap align-items-center">
              <i class="ti ti-clipboard-text ti-sm"></i>
              <span class="align-middle ms-2 fw-normal">결재내역</span>
            </a>
          </li>
          <li class="d-flex align-items-center" data-target="trash">
            <a href="javascript:void(0);" class="d-flex flex-wrap align-items-center">
              <i class="ti ti-progress ti-sm"></i>
              <span class="align-middle ms-2 fw-normal">결재예정</span>
            </a>
          </li>
          <li class="d-flex align-items-center" data-target="trash">
            <a href="javascript:void(0);" class="d-flex flex-wrap align-items-center">
              <i class="ti ti-user ti-sm"></i>
              <span class="align-middle ms-2 fw-normal">대리결재</span>
            </a>
          </li>
          <li class="d-flex justify-content-between" data-target="trash">
            <a href="javascript:void(0);" class="d-flex flex-wrap align-items-center">
              <i class="ti ti-inbox ti-sm"></i>
              <span class="align-middle ms-2 fw-normal">수신참조</span>
            </a>
            <div class="badge bg-label-warning rounded-pill badge-center">10</div>
          </li>
        </ul>
        
        <!-- Email Filters: Labels -->
        <div class="email-filter-labels">
          <small class="fw-normal text-uppercase text-muted m-4">보관함</small>
          <ul class="list-unstyled mb-0 mt-2">
            <li data-target="work">
              <a href="javascript:void(0);">
                <span class="badge badge-dot bg-secondary"></span>
                <span class="align-middle ms-2 fw-normal">개인 보관함</span>
              </a>
            </li>
            <li data-target="company">
              <a href="javascript:void(0);">
                <span class="badge badge-dot bg-secondary"></span>
                <span class="align-middle ms-2 fw-normal">부서 보관함</span>
              </a>
            </li>
            <li data-target="important">
              <a href="javascript:void(0);">
                <span class="badge badge-dot bg-secondary"></span>
                <span class="align-middle ms-2 fw-normal">기타 보관함</span>
              </a>
            </li>
          </ul>
        </div>
        <!--/ Email Filters -->
      </div>
    </div>
    <!--/ Email Sidebar -->
  </div>

</div>
<div id="test"></div>


<!-- Modal -->
<div class="modal fade" id="newApprovalModal" tabindex="-1" aria-labelledby="newApproval" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
          </button>
      </div>
      <div class="modal-body">
        <p>Croissant jelly beans donut apple pie. Caramels bonbon lemon drops. Sesame snaps lemon drops lemon drops liquorice icing bonbon pastry pastry carrot cake. Dragée sweet sweet roll sugar plum.</p>
        <p>Jelly-o cookie jelly gummies pudding cheesecake lollipop macaroon. Sweet chocolate bar sweet roll carrot cake. Sweet roll sesame snaps fruitcake brownie bear claw toffee bonbon brownie.</p>
        <a href="/approval/new?atCd=AT01">업무기안서</a>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
<!--                                         <tr> -->
<!--                                             <td><h6 class="mb-0 align-items-center d-flex w-px-100 text-danger"><i class="ti ti-circle-filled fs-tiny me-2"></i>긴급</h6></td> -->
<!--                                             <td>프로젝트 계획 검토</td> -->
<!--                                             <td>2024-06-10 09:30</td> -->
<!--                                             <td> -->
<!--                                             	<div class="d-flex justify-content-start align-items-center order-name text-nowrap"> -->
<!-- 	                                            	<div class="avatar-wrapper"> -->
<!-- 		                                            	<div class="avatar me-2"> -->
<!-- 		                                            		<img src="/resources/vuexy/assets/img/avatars/user-1.jpg" alt="Avatar" class="rounded-circle"> -->
<!-- 		                                            	</div> -->
<!-- 	                                            	</div> -->
<!-- 	                                            	<div class="d-flex flex-column"> -->
<!-- 		                                            	<h6 class="m-0"> -->
<!-- 		                                            		<a href="pages-profile-user.html" class="text-body">김태평</a> -->
<!-- 		                                            	</h6> -->
<!-- 	                                            		<small class="text-muted">전략기획팀</small> -->
<!-- 	                                            	</div> -->
<!--                                             	</div> -->
<!--                                             </td> -->
<!--                                             <td><span class="badge bg-label-warning">진행</span></td> -->
<!--                                             <td> -->
<!--                                                 <div class="progress-container"> -->
<!--                                                     <div class="progress-line"></div> -->
<!--                                                     <div class="progress-step completed"> -->
<!--                                                         <div class="icon"> -->
<!--                                                             <i class="fa-solid fa-check"></i> -->
<!--                                                         </div> -->
<!--                                                         <p>김철수</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step completed"> -->
<!--                                                         <div class="icon"> -->
<!--                                                             <i class="fa-solid fa-check"></i> -->
<!--                                                         </div> -->
<!--                                                         <p>이영희</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>박민수</p> -->
<!--                                                     </div> -->
<!--                                                 </div> -->
<!--                                             </td> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td></td> -->
<!--                                             <td>예산 배정</td> -->
<!--                                             <td>2024-06-11 14:15</td> -->
<!--                                             <td> -->
<!--                                             	<div class="d-flex justify-content-start align-items-center order-name text-nowrap"> -->
<!-- 	                                            	<div class="avatar-wrapper"> -->
<!-- 		                                            	<div class="avatar me-2"> -->
<!-- 		                                            		<img src="/resources/vuexy/assets/img/avatars/user-2.jpg" alt="Avatar" class="rounded-circle"> -->
<!-- 		                                            	</div> -->
<!-- 	                                            	</div> -->
<!-- 	                                            	<div class="d-flex flex-column"> -->
<!-- 		                                            	<h6 class="m-0"> -->
<!-- 		                                            		<a href="pages-profile-user.html" class="text-body">김태평</a> -->
<!-- 		                                            	</h6> -->
<!-- 	                                            		<small class="text-muted">전략기획팀</small> -->
<!-- 	                                            	</div> -->
<!--                                             	</div> -->
<!--                                             </td> -->
<!--                                             <td><span class="badge bg-label-warning">진행</span></td> -->
<!--                                             <td> -->
<!--                                                 <div class="progress-container"> -->
<!--                                                     <div class="progress-line"></div> -->
<!--                                                     <div class="progress-step completed"> -->
<!--                                                         <div class="icon"> -->
<!--                                                             <i class="fa-solid fa-check"></i> -->
<!--                                                         </div> -->
<!--                                                         <p>김철수</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>이영희</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>박민수</p> -->
<!--                                                     </div> -->
<!--                                                 </div> -->
<!--                                             </td> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td><h6 class="mb-0 align-items-center d-flex w-px-100 text-danger"><i class="ti ti-circle-filled fs-tiny me-2"></i>긴급</h6></td> -->
<!--                                             <td>팀 회의 기록</td> -->
<!--                                             <td>2024-06-12 11:00</td> -->
<!--                                             <td> -->
<!--                                             	<div class="d-flex justify-content-start align-items-center order-name text-nowrap"> -->
<!-- 	                                            	<div class="avatar-wrapper"> -->
<!-- 		                                            	<div class="avatar me-2"> -->
<!-- 		                                            		<img src="/resources/vuexy/assets/img/avatars/user-3.jpg" alt="Avatar" class="rounded-circle"> -->
<!-- 		                                            	</div> -->
<!-- 	                                            	</div> -->
<!-- 	                                            	<div class="d-flex flex-column"> -->
<!-- 		                                            	<h6 class="m-0"> -->
<!-- 		                                            		<a href="pages-profile-user.html" class="text-body">김태평</a> -->
<!-- 		                                            	</h6> -->
<!-- 	                                            		<small class="text-muted">전략기획팀</small> -->
<!-- 	                                            	</div> -->
<!--                                             	</div> -->
<!--                                             </td> -->
<!--                                             <td><span class="badge bg-label-warning">진행</span></td> -->
<!--                                             <td> -->
<!--                                                 <div class="progress-container"> -->
<!--                                                     <div class="progress-line"></div> -->
<!--                                                     <div class="progress-step completed"> -->
<!--                                                         <div class="icon"> -->
<!--                                                             <i class="fa-solid fa-check"></i> -->
<!--                                                         </div> -->
<!--                                                         <p>김철수</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>이영희</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>박민수</p> -->
<!--                                                     </div> -->
<!--                                                 </div> -->
<!--                                             </td> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td></td> -->
<!--                                             <td>고객 피드백</td> -->
<!--                                             <td>2024-06-13 16:45</td> -->
<!--                                             <td> -->
<!--                                             	<div class="d-flex justify-content-start align-items-center order-name text-nowrap"> -->
<!-- 	                                            	<div class="avatar-wrapper"> -->
<!-- 		                                            	<div class="avatar me-2"> -->
<!-- 		                                            		<img src="/resources/vuexy/assets/img/avatars/user-4.jpg" alt="Avatar" class="rounded-circle"> -->
<!-- 		                                            	</div> -->
<!-- 	                                            	</div> -->
<!-- 	                                            	<div class="d-flex flex-column"> -->
<!-- 		                                            	<h6 class="m-0"> -->
<!-- 		                                            		<a href="pages-profile-user.html" class="text-body">김태평</a> -->
<!-- 		                                            	</h6> -->
<!-- 	                                            		<small class="text-muted">전략기획팀</small> -->
<!-- 	                                            	</div> -->
<!--                                             	</div> -->
<!--                                             </td> -->
<!--                                             <td><span class="badge bg-label-secondary">반려</span></td> -->
<!--                                             <td> -->
<!--                                                 <div class="progress-container"> -->
<!--                                                     <div class="progress-line"></div> -->
<!--                                                     <div class="progress-step completed"> -->
<!--                                                         <div class="icon"> -->
<!--                                                             <i class="fa-solid fa-check"></i> -->
<!--                                                         </div> -->
<!--                                                         <p>김철수</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>이영희</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>박민수</p> -->
<!--                                                     </div> -->
<!--                                                 </div> -->
<!--                                             </td> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td></td> -->
<!--                                             <td>분기 보고서</td> -->
<!--                                             <td>2024-06-14 10:30</td> -->
<!--                                             <td> -->
<!--                                             	<div class="d-flex justify-content-start align-items-center order-name text-nowrap"> -->
<!-- 	                                            	<div class="avatar-wrapper"> -->
<!-- 		                                            	<div class="avatar me-2"> -->
<!-- 		                                            		<img src="/resources/vuexy/assets/img/avatars/user-5.jpg" alt="Avatar" class="rounded-circle"> -->
<!-- 		                                            	</div> -->
<!-- 	                                            	</div> -->
<!-- 	                                            	<div class="d-flex flex-column"> -->
<!-- 		                                            	<h6 class="m-0"> -->
<!-- 		                                            		<a href="pages-profile-user.html" class="text-body">김태평</a> -->
<!-- 		                                            	</h6> -->
<!-- 	                                            		<small class="text-muted">전략기획팀</small> -->
<!-- 	                                            	</div> -->
<!--                                             	</div> -->
<!--                                             </td> -->
<!--                                             <td><span class="badge bg-label-secondary">반려</td> -->
<!--                                             <td> -->
<!--                                                 <div class="progress-container"> -->
<!--                                                     <div class="progress-line"></div> -->
<!--                                                     <div class="progress-step completed"> -->
<!--                                                         <div class="icon"> -->
<!--                                                             <i class="fa-solid fa-check"></i> -->
<!--                                                         </div> -->
<!--                                                         <p>김철수</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>이영희</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>박민수</p> -->
<!--                                                     </div> -->
<!--                                                 </div> -->
<!--                                             </td> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td></td> -->
<!--                                             <td>마케팅 전략</td> -->
<!--                                             <td>2024-06-15 15:00</td> -->
<!--                                             <td> -->
<!--                                             	<div class="d-flex justify-content-start align-items-center order-name text-nowrap"> -->
<!-- 	                                            	<div class="avatar-wrapper"> -->
<!-- 		                                            	<div class="avatar me-2"> -->
<!-- 		                                            		<img src="/resources/vuexy/assets/img/avatars/user-6.jpg" alt="Avatar" class="rounded-circle"> -->
<!-- 		                                            	</div> -->
<!-- 	                                            	</div> -->
<!-- 	                                            	<div class="d-flex flex-column"> -->
<!-- 		                                            	<h6 class="m-0"> -->
<!-- 		                                            		<a href="pages-profile-user.html" class="text-body">김태평</a> -->
<!-- 		                                            	</h6> -->
<!-- 	                                            		<small class="text-muted">전략기획팀</small> -->
<!-- 	                                            	</div> -->
<!--                                             	</div> -->
<!--                                             </td> -->
<!--                                             <td><span class="badge bg-label-warning">진행</span></td> -->
<!--                                             <td> -->
<!--                                                 <div class="progress-container"> -->
<!--                                                     <div class="progress-line"></div> -->
<!--                                                     <div class="progress-step completed"> -->
<!--                                                         <div class="icon"> -->
<!--                                                             <i class="fa-solid fa-check"></i> -->
<!--                                                         </div> -->
<!--                                                         <p>김철수</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>이영희</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>박민수</p> -->
<!--                                                     </div> -->
<!--                                                 </div> -->
<!--                                             </td> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td></td> -->
<!--                                             <td>제품 출시 계획</td> -->
<!--                                             <td>2024-06-16 13:00</td> -->
<!--                                             <td> -->
<!--                                             	<div class="d-flex justify-content-start align-items-center order-name text-nowrap"> -->
<!-- 	                                            	<div class="avatar-wrapper"> -->
<!-- 		                                            	<div class="avatar me-2"> -->
<!-- 		                                            		<img src="/resources/vuexy/assets/img/avatars/user-7.jpg" alt="Avatar" class="rounded-circle"> -->
<!-- 		                                            	</div> -->
<!-- 	                                            	</div> -->
<!-- 	                                            	<div class="d-flex flex-column"> -->
<!-- 		                                            	<h6 class="m-0"> -->
<!-- 		                                            		<a href="pages-profile-user.html" class="text-body">김태평</a> -->
<!-- 		                                            	</h6> -->
<!-- 	                                            		<small class="text-muted">전략기획팀</small> -->
<!-- 	                                            	</div> -->
<!--                                             	</div> -->
<!--                                             </td> -->
<!--                                             <td><span class="badge bg-label-secondary">반려</td> -->
<!--                                             <td> -->
<!--                                                 <div class="progress-container"> -->
<!--                                                     <div class="progress-line"></div> -->
<!--                                                     <div class="progress-step completed"> -->
<!--                                                         <div class="icon"> -->
<!--                                                             <i class="fa-solid fa-check"></i> -->
<!--                                                         </div> -->
<!--                                                         <p>김철수</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>이영희</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>박민수</p> -->
<!--                                                     </div> -->
<!--                                                 </div> -->
<!--                                             </td> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td></td> -->
<!--                                             <td>판매 데이터 분석</td> -->
<!--                                             <td>2024-06-17 09:00</td> -->
<!--                                             <td> -->
<!--                                             	<div class="d-flex justify-content-start align-items-center order-name text-nowrap"> -->
<!-- 	                                            	<div class="avatar-wrapper"> -->
<!-- 		                                            	<div class="avatar me-2"> -->
<!-- 		                                            		<img src="/resources/vuexy/assets/img/avatars/user-8.jpg" alt="Avatar" class="rounded-circle"> -->
<!-- 		                                            	</div> -->
<!-- 	                                            	</div> -->
<!-- 	                                            	<div class="d-flex flex-column"> -->
<!-- 		                                            	<h6 class="m-0"> -->
<!-- 		                                            		<a href="pages-profile-user.html" class="text-body">김태평</a> -->
<!-- 		                                            	</h6> -->
<!-- 	                                            		<small class="text-muted">전략기획팀</small> -->
<!-- 	                                            	</div> -->
<!--                                             	</div> -->
<!--                                             </td> -->
<!--                                             <td><span class="badge bg-label-success">완료</span></td> -->
<!--                                             <td> -->
<!--                                                 <div class="progress-container"> -->
<!--                                                     <div class="progress-line"></div> -->
<!--                                                     <div class="progress-step completed"> -->
<!--                                                         <div class="icon"> -->
<!--                                                             <i class="fa-solid fa-check"></i> -->
<!--                                                         </div> -->
<!--                                                         <p>김철수</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>이영희</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>박민수</p> -->
<!--                                                     </div> -->
<!--                                                 </div> -->
<!--                                             </td> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td></td> -->
<!--                                             <td>연례 총회</td> -->
<!--                                             <td>2024-06-18 10:00</td> -->
<!--                                             <td> -->
<!--                                             	<div class="d-flex justify-content-start align-items-center order-name text-nowrap"> -->
<!-- 	                                            	<div class="avatar-wrapper"> -->
<!-- 		                                            	<div class="avatar me-2"> -->
<!-- 		                                            		<img src="/resources/vuexy/assets/img/avatars/user-9.jpg" alt="Avatar" class="rounded-circle"> -->
<!-- 		                                            	</div> -->
<!-- 	                                            	</div> -->
<!-- 	                                            	<div class="d-flex flex-column"> -->
<!-- 		                                            	<h6 class="m-0"> -->
<!-- 		                                            		<a href="pages-profile-user.html" class="text-body">김태평</a> -->
<!-- 		                                            	</h6> -->
<!-- 	                                            		<small class="text-muted">전략기획팀</small> -->
<!-- 	                                            	</div> -->
<!--                                             	</div> -->
<!--                                             </td> -->
<!--                                             <td><span class="badge bg-label-success">완료</span></td> -->
<!--                                             <td> -->
<!--                                                 <div class="progress-container"> -->
<!--                                                     <div class="progress-line"></div> -->
<!--                                                     <div class="progress-step completed"> -->
<!--                                                         <div class="icon"> -->
<!--                                                             <i class="fa-solid fa-check"></i> -->
<!--                                                         </div> -->
<!--                                                         <p>김철수</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>이영희</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>박민수</p> -->
<!--                                                     </div> -->
<!--                                                 </div> -->
<!--                                             </td> -->
<!--                                         </tr> -->
<!--                                         <tr> -->
<!--                                             <td></td> -->
<!--                                             <td>성과 평가</td> -->
<!--                                             <td>2024-06-19 14:30</td> -->
<!--                                             <td> -->
<!--                                             	<div class="d-flex justify-content-start align-items-center order-name text-nowrap"> -->
<!-- 	                                            	<div class="avatar-wrapper"> -->
<!-- 		                                            	<div class="avatar me-2"> -->
<!-- 		                                            		<img src="/resources/vuexy/assets/img/avatars/user-3.jpg" alt="Avatar" class="rounded-circle"> -->
<!-- 		                                            	</div> -->
<!-- 	                                            	</div> -->
<!-- 	                                            	<div class="d-flex flex-column"> -->
<!-- 		                                            	<h6 class="m-0"> -->
<!-- 		                                            		<a href="pages-profile-user.html" class="text-body">김태평</a> -->
<!-- 		                                            	</h6> -->
<!-- 	                                            		<small class="text-muted">전략기획팀</small> -->
<!-- 	                                            	</div> -->
<!--                                             	</div> -->
<!--                                             </td> -->
<!--                                             <td><span class="badge bg-label-success">완료</span></td> -->
<!--                                             <td> -->
<!--                                                 <div class="progress-container"> -->
<!--                                                     <div class="progress-line"></div> -->
<!--                                                     <div class="progress-step completed"> -->
<!--                                                         <div class="icon"> -->
<!--                                                             <i class="fa-solid fa-check"></i> -->
<!--                                                         </div> -->
<!--                                                         <p>김철수</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>이영희</p> -->
<!--                                                     </div> -->
<!--                                                     <div class="progress-step"> -->
<!--                                                         <div class="icon"> -->
<!--                                                         </div> -->
<!--                                                         <p>박민수</p> -->
<!--                                                     </div> -->
<!--                                                 </div> -->
<!--                                             </td> -->
<!--                                         </tr> -->

<!-- Page JS -->
