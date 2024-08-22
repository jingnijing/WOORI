$('#dogName').on('input',request)

function request(){
	
	$.ajax({
		url : "check",
		type : "POST",
        data : { "pet" : $('#dogName').val()},
        success : function(res) {
			console.log(res);
			
			if(res=="true"){
				$('#result').text("사용가능한 이름입니다").css("color","green")
			}else{
				$('#result').text("중복된 이름입니다").css("color","red")		
			}
			
			
        }
	});
	
}