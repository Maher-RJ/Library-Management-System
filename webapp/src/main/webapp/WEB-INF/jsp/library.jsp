<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>
<head>
<title>Library</title>
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.12/css/dataTables.bootstrap.min.css"
	rel="stylesheet" />

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.12/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.12/js/dataTables.bootstrap.min.js"></script>

</head>
<body style="padding-top: 70px">
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="/">Library Management</a>
			</div>
			<ul class="nav navbar-nav">
				<li><a href="/">Home</a></li>
				<li class="active"><a href="/library">Library Items</a></li>
				<li><a href="/categories">Categories</a></li>
				<li><a href="/employees">Employees</a></li>
			</ul>
		</div>
	</nav>


	<div class="container">
		<div class="text">
			<h3 class="display-4">Library Items</h3>
			<hr>
		</div>
		<div class="table">
			<table class="table table-striped table-bordered table-hover"
				style="font-size: 0.9em" id="libraryItems">
				<thead>
					<tr>
						<th>Id</th>
						<th>Title</th>
						<th>Author</th>
						<th>Type</th>
						<th>Category</th>
						<th>Pages</th>
						<th>Runtime(min)</th>
						<th>Borrowable</th>
						<th>Borrower</th>
						<th>Borrow Date</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="libraryItem" items="${list}">
						<tr>
							<td>${libraryItem.id}</td>
							<td>${libraryItem.title}</td>
							<td>${libraryItem.author}</td>
							<td><span style=" text-transform: uppercase">${libraryItem.type}</span></td>
							<td>${libraryItem.category.categoryName}</td>
							<td>${libraryItem.pages}</td>
							<td>${libraryItem.runTimeMinutes}</td>
							<td>${libraryItem.isBorrowable}</td>
							<td>${libraryItem.borrower}</td>
							<td>${libraryItem.borrowDate}</td>
							<td><a href="library/edit/${libraryItem.id}">Edit</a><span>
									| </span><a href="library/delete/${libraryItem.id}">Delete</a> <c:if
									test="${libraryItem.isBorrowable == false && libraryItem.type != 'referencebook'}">
									<span> | </span>
									<a href="library/checkin/${libraryItem.id}">Check in</a>
								</c:if> <c:if test="${libraryItem.isBorrowable == true && libraryItem.type != 'referencebook'}">
									<span> | </span>
									<a href="library/checkout/${libraryItem.id}">Checkout</a>
								</c:if></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<hr />
		<div class="text">
			<h4 class="display-4">Add Library Item</h4>
		</div>
		<hr />
		<form method="post" action="library" name="libraryItemsForm" id="libraryItemsForm">

			<div class="form-group">
				<label>Type </label><select name="type" class="form-control"
					id="type" required>
					<option value="">Select a type</option>
					<option value="book">Book</option>
					<option value="referencebook">Reference book</option>
					<option value="dvd">DVD</option>
					<option value="audiobook">Audio book</option>
				</select>
			</div>
			<div class="form-group" id="title">
				<label>Title </label><input name="title" type="text"
					class="form-control" placeholder="Enter Title" required=required
					id="inputTitle" />
			</div>
			<div class="form-group" id="author">
				<label>Author </label><input name="author" type="text"
					class="form-control" placeholder="Enter Author" id="inputAuthor" />
			</div>
			<div class="form-group" id="category">
				<label>Category - </label><a class="btn" href="/categories">Add
					Category</a> <br> <select name="category" class="form-control"
					id="inputCategory" required>
					<option value="">Select a Category</option>
					<c:forEach var="item" items="${categoryList}">
						<option value="${item.getId()}">${item.getCategoryName()}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group" id="pages">
				<label>No. of Pages</label><input name="pages" type="number"
					class="form-control" placeholder="Enter Number of Pages"
					id="inputPages" />
			</div>
			<div class="form-group" id="runTimeMinutes">
				<label>Runtime (minutes)</label><input name="runTimeMinutes"
					type="number" class="form-control"
					placeholder="Enter Runtime in minutes" id="inputRuntimeMinutes" />
			</div>
			<div class="form-group" id="borrowable">
				<label>Borrowable</label><select name="borrowable"
					id="selectBorrowable" class="form-control" required>
					<option value="">Select True/False</option>
					<option value="true">True</option>
					<option value="false">False</option>
				</select>
			</div>
			<div class="form-group" id="borrower">
				<label>Borrower Name</label><input id="inputBorrower"
					name="borrower" type="text" class="form-control"
					placeholder="Enter Borrower Name" />
			</div>
			<div class="form-group" id="borrowDate">
				<label>Borrow Date</label><input name="borrowDate" type="date"
					class="form-control" id="datepicker"
					placeholder="Select Borrow Date"/>
			</div>
			<button type="submit" id="PageRefresh" class="btn btn-primary">Add</button>
		</form>


		<!-- Sorting the library items script -->
		<script>
			$(document).ready(function() {
				$('#libraryItems').DataTable( {
			        "order": [[ 4, "asc" ]]
			    });
				
				
			});
		
		</script>
		

		<!-- Script to hide the input fields except the 'type' combo box -->
		<!-- Script for Selecting 'type' for hiding and showing the input fields -->
		<script>
			function hideAll() {
				$("#title").hide();
				$("#author").hide();
				$("#category").hide();
				$("#pages").hide();
				$("#runTimeMinutes").hide();
				$("#borrowable").hide();
				$("#borrower").hide();
				$("#borrowDate").hide();
			}

			$(document).ready(hideAll());
			//Hiding borrower and borrowDate if borrowable is true
			$(function() {
				$("#borrowable").change(function() {
					var value = $("#borrowable").find(":selected").val();
					if (value == "true") {
						$("#borrower").hide();
						$("#inputBorrower").removeAttr("required");
						$("#borrowDate").hide();
						$("#datepicker").removeAttr("required");

					} else if (value == "false") {
						$("#borrower").show();
						$("#inputBorrower").attr("required", true);
						$("#borrowDate").show();
						$("#datepicker").attr("required", true);
					}
				});
			});

			//Show input field according to the type
			$(function() {
				$("#type")
						.change(
								function() {
									var value = $('#type').find(":selected")
											.val();

									if (value == "book") {
										hideAll();
										$("#title").show();
										$("#author").show();
										$("#category").show();
										$("#pages").show();
										$("#borrowable").show();
										$("#borrower").show();
										$("#borrowDate").show();
										$('#selectBorrowable').attr("disabled",
												false);
										//making attribute required
										$("#inputAuthor").attr("required",
												"required");
										$("#inputPages").attr("required",
												"required");
										//document.getElementById("author").required = true;
										//document.getElementById("pages").required = true;
										//making attribute not required 
										$("#inputRuntimeMinutes").removeAttr(
												'required');

									} else if (value == "dvd"
											|| value == "audiobook") {
										hideAll();
										$('#selectBorrowable').attr("disabled",
												false);
										$("#title").show();
										$("#runTimeMinutes").show();
										$("#category").show();
										$("#borrowable").show();
										$("#borrower").show();
										$("#borrowDate").show();
										//making attribute required
										$("#inputRuntimeMinutes").attr(
												"required", "required");

										//document.getElementById("runTimeMinutes").required = true;
										//making attribute not required 
										//document.getElementById("author").required = false;
										//document.getElementById("pages").required = false;
										$("#inputAuthor")
												.removeAttr("required");
										$("#inputPages").removeAttr("required");

									} else if (value == "referencebook") {
										hideAll();
										$("#title").show();
										$("#author").show();
										$("#category").show();
										$("#pages").show();
										$("#borrowable").show();
										//making attribute required
										$("#inputAuthor").attr("required",
												"required");
										$("#inputPages").attr("required",
												"required");
										//making attribute not required 
										$("#inputRuntimeMinutes").removeAttr(
												'required');
										//Setting default value 'false' for borrowable as required!
										$(
												'#selectBorrowable option[value="false"]')
												.attr("selected", true);
										$('#selectBorrowable').attr("disabled",
												true);

									}
								})

			});
		</script>
		<!-- Script to reload the categories page after adding a category-->
		<script type="text/javascript">
			$('#libraryItemsForm').onsubmit(function() {
				location.reload();
			});
		</script>
	</div>

</body>
</html>