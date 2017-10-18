document.addEventListener("turbolinks:load", function (){	
	$('#cat').css("display", "none");
	
	$('#pet_pet_type_dog').click(function(){
		$('#cat').css("display", "none");
		$('#dog').css("display", "block")
		

	});

	$('#pet_pet_type_cat').click(function(){
		$('#dog').css("display", "none");
		$('#cat').css("display", "block")
	});



});