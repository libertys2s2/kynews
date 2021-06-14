/**
 * 
 * 
 * 
 * 
 */
$(document).ready(function(){
	
	var result='<c:out value="${result}"/>';
	checkModal(result);
	
	function checkModal(result){
		if(result===''){
			return;
		}
		if(parseInt(result) >0){
			$("#modal-body").html("게시글"+parseInt(result)+"번이 등록되었습니다");
	}
	$("#myModal").modal("show");
}
});
