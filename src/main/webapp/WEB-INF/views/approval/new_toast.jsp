<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdn.ckeditor.com/ckeditor5/41.4.2/classic/ckeditor.js"></script>

<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.css" />

<title>Insert title here</title>
</head>
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<body>
<table border="1">
	<tr>
		<td>제목</td>
		<td><input /></td>
	</tr>
</table>
<div id="editor"></div>
<script>
const urlParams = new URL(location.href).searchParams;
const atCd= urlParams.get('atCd');

const Editor = toastui.Editor;
const editor = new Editor({
	height: 'auto',
  	el: document.querySelector('#editor'),
  	initialEditType: 'wysiwyg',
// 	  toolbarItems: [
// 	    ['heading', 'bold', 'italic', 'strike'],
// 	    ['hr', 'quote'],
// 	    // ...
// 	  ],
	  // ...
});
	
		
$(function(){
	fetch("/approval/"+atCd)
		.then((resp)=>{
			resp.json().then((data)=>{
				console.log(data);
				editor.setHTML(data.atCn);
			})
		})
// 	console.log(atCd);
});
</script>
</body>
</html>