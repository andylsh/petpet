// document.addEventListener("turbolinks:load", function (){	
// 	$('#cat').css("display", "none");
	
// 	$('#pet_pet_type_dog').click(function(){
// 		$('#cat').css("display", "none");
// 		$('#dog').css("display", "block")
		

// 	});

// 	$('#pet_pet_type_cat').click(function(){
// 		$('#dog').css("display", "none");
// 		$('#cat').css("display", "block")
// 	});



// });

 document.addEventListener("turbolinks:load", function (){
	var clone_dog = $('#image_dog').detach();
	var clone_cat = $('#image_cat').detach();
	clone_dog.appendTo('#dog');
	$('#image_cat').remove(); 
	$('#pet_pet_type_dog').click(function(){
		clone_dog.appendTo('#dog');
		$('#image_cat').remove(); 
	});

	$('#pet_pet_type_cat').click(function(){
		clone_cat.appendTo('#cat');
		$('#image_dog').remove();
		$('#pet_photo').val("http://placehold.it/200x200/EEE")
	});

	
		
});