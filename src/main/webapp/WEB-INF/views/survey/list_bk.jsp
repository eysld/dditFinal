<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
const urlParams = new URL(location.href).searchParams;
const currentPage = urlParams.get('currentPage') == null ? 1 : urlParams.get('currentPage');

$(function(){
    getList(currentPage);
   
    $('#btnInsert').on('click', function(){
        location.href="/survey/insert";
    });
});

async function getParticipationStatus(participateData) {
    try {
        let participateResult = await $.ajax({
            url: "/survey/checkParticipate",
            contentType: "application/json",
            data: JSON.stringify(participateData),
            type: "post",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            }
        });

        return participateResult === 'TRUE';
    } catch (error) {
        console.error("Error fetching participation data: ", error);
        return false; // 또는 필요한 처리를 수행하십시오.
    }
}

async function getList(currentPage) {
    let data = { "currentPage": currentPage };
    console.log("data : ", data);

    try {
        let result = await $.ajax({
            url: "/survey/getList",
            data: data,
            type: "get",
            dataType: "json"
        });

        console.log(result);
        let str = `<h6>총 \${result.total}건</h6>`;
        let now = new Date();

        for (const surveyVO of result.content) {
            str += `
                <div class="col-sm-6 col-lg-4">
                    <div class="card p-2 h-100 shadow-none border">
                        <div class="card-body p-3 pt-2">
                            <div class="d-flex justify-content-between align-items-center mb-3">`;

            if (surveyVO.srvyEndYmd > now) {
                str += `<span class="badge bg-label-success">진행중</span>`;
            } else {
                str += `<span class="badge bg-label-primary">마감</span>`;
            }

            let participateData = {
                "empId": "202406080007",
                "srvyNo": surveyVO.srvyNo
            };

            const isParticipated = await getParticipationStatus(participateData);
            if (isParticipated) {
                str += `<i class="ti ti-circle-check ti-sm"></i>`;
            }

            str += `</div>
                        <a class="h5">\${surveyVO.srvyTtl}</a>
                        <p class="mt-2">\${surveyVO.empNm}</p>
                        <p class="d-flex align-items-center"><i class="ti ti-clock me-2 mt-n1"></i>\${surveyVO.strBegin} - \${surveyVO.strEnd}</p>
                        <div class="progress mb-4" style="height: 8px">`
            if (surveyVO.srvyEndYmd > now) {
                      str += `<div class="progress-bar w-50" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>`;
            } else {
                      str += `<div class="progress-bar w-100" role="progressbar" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>`;
            }                  
               str += `
                  </div>
                  <div class="d-flex flex-column flex-md-row gap-2 text-nowrap">`;

            if (isParticipated || surveyVO.srvyEndYmd < now) {
                str += `<a class="app-academy-md-50 btn btn-label-secondary me-md-2 d-flex align-items-center" href="/survey/result?srvyNo=\${surveyVO.srvyNo}">
                                <i class="ti ti-rotate-clockwise-2 align-middle scaleX-n1-rtl me-2 mt-n1 ti-sm"></i><span>결과보기</span></a>`;
            } else {
                str += `<a class="app-academy-md-50 btn btn-label-primary d-flex align-items-center" href="/survey/detail?srvyNo=\${surveyVO.srvyNo}">
                                <span class="me-2">설문하기</span><i class="ti ti-chevron-right scaleX-n1-rtl ti-sm"></i></a>`;
            }

            str += `</div></div></div></div>`;
        }

        $('#box').html(str);
        $('#pagingBox').html(result.pagingArea2);
    } catch (error) {
        console.error(error);
    }
}
</script>
<div class="app-academy">
    <div class="card mb-4">
        <div class="card-body">
            <div class="row gy-4 mb-4" id="box"></div>
            <!-- 페이징 -->
            <div id="pagingBox"></div>
        </div>
    </div>
</div>
<button id="btnInsert">설문 등록</button>
