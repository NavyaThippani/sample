<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cloud Application</title>
<!--  <link href="css/home.css" rel="stylesheet" type="text/css" />-->
<style>
	/* CSS Document */ 

	.offscreen { 
	  position: absolute; 
	  top: -30em; 
	  left: -300em; 
	} 

	div#hmenu { 
	   margin: 0; 
	   padding: .3em 0 .3em 0; 
	   background: #ddeebb; 
	   width: 50%; 
	   text-align: center; 
	} 

	div#hmenu ul { 
	   list-style: none; 
	   margin: 0; 
	   padding: 0; 
	} 

	div#hmenu ul li { 
	   margin: 0; 
	   padding: 0; 
	   display: inline; 
	} 

	div#hmenu ul a:link{ 
	   margin: 0; 
	   padding: .3em .4em .3em .4em; 
	   text-decoration: none; 
	   font-weight: bold; 
	   font-size: medium; 
	   color: #004415; 
	} 

	div#hmenu ul a:visited{ 
	   margin: 0; 
	   padding: .3em .4em .3em .4em; 
	   text-decoration: none; 
	   font-weight: bold; 
	   font-size: medium; 
	   color: #227755; 
	} 

	div#hmenu ul a:active{ 
	   margin: 0; 
	   padding: .3em .4em .3em .4em; 
	   text-decoration: none; 
	   font-weight: bold; 
	   font-size: medium; 
	   color: #227755; 
	} 

	div#hmenu ul a:hover{ 
	   margin: 0; 
	   padding: .3em .4em .3em .4em; 
	   text-decoration: none; 
	   font-weight: bold; 
	   font-size: medium; 
	   color: #f6f0cc; 
	   background-color: #227755; 
	}

	.textareastyle {
		overflow:auto;
		resize:none;
		height: 100px;
		width: 800px;
		max-height: 300px;
		border-radius: 7px;
	}

	.tablestyle {
		clear: both;
		WIDTH:50%;
		border-collapse:collapse;
		padding: 10px;
		 
	    /* only out border for table*/
	    border-style: solid;
	    border-width: 1px;
	    border-radius: 7px;
	}
	.thstyle{
		text-align:left;
		WIDTH:10%;
		border-style: solid;
	    border-width: 1px;
	}
	.trstyle{
		WIDTH:40%;
		text-align:left;
		border-style: solid;
	    border-width: 1px;
	}
	.tablestyleSmall{
		clear: both;
		WIDTH:25%;
		border-collapse:collapse;
		border-radius: 7px;
	}
	.buttonStyle{
		height: 40px; 
		width:200px; 
		text-align: center; 
		color: blue;
		border-radius: 7px;
		margin-right:50px;
	}

	.callButtonStyle{
		height: 40px; 
		width:80px; 
		text-align: center; 
		color: blue;
		border-radius: 7px;
		margin-right:8px;
		margin-left:8px;
	}
	.textboxStyle{
		height: 30px;
		width:200px;
		text-aligh: left;
		border-radius: 7px;
		margin-right:20px;
	}
	.selectStyle{
		height: 35px;
		width: 200px;
		text-aligh: left;
		border-radius: 7px;
		margin-right:20px;
	}
	.dropdownStyle{
		height: 35px;
		width: 70px;
		text-aligh: right;
		border-radius: 7px;
	}
	.divStyle{
		background-color:white; 
		display: table; 
		max-width: 200px; 
		padding: 10px; 
		margin: 0 auto 40px;
		border-radius: 7px;
	}
	.smallselectStyle{
		height: 35px;
		width: 100px;
		text-aligh: left;
		border-radius: 7px;
		margin-right:8px;
		margin-left:8px;
	}
	.smalltextboxStyle{
		height: 30px;
		width:100px;
		text-aligh: left;
		border-radius: 7px;
		margin-right:8px;
		margin-left:8px;
	}
	</style>
</head>
<body background="plain-gray-background.jpg">
	<div style="text-align: center">
		<br> <br>
		<h2>Cloud Application</h2>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script>
	
		var devicesList;

		$(document).ready(function() {
			$.getJSON('http://192.168.0.100:8091/devices', function(json) {
				//data is the JSON string
				//console.log(json);
				//alert(json);
				var jsonString = JSON.stringify(json);
				//alert(json);
				var tr;
				for (var i = 0; i < json.length; i++) {
					tr = $('<tr/>');
					tr.append("<td class='thstyle'>" + json[i].id + "</td>");
					tr.append("<td class='thstyle'>" + json[i].assetId + "</td>");
					tr.append("<td class='thstyle'>" + json[i].clientId + "</td>");
					tr.append("<td class='thstyle'>" + json[i].enabled + "</td>");
					tr.append("<td class='thstyle'>" + json[i].imei + "</td>");
					tr.append("<td class='thstyle'><select class='smallselectStyle' id='innerparamtype1'>"+											
							+ "<option value='id'>Device Id</option>"+
							+ "<option value='assetId'>Asset Id</option>"+
							+ "<option value='clientId'>Client Id</option>"+
							+ "<option value='enabled'>Enabled</option>"+
							+ "<option value='imei'>IMEI</option>"+
						    + "</select> </td>");
				    
					tr.append("<td class='thstyle'><input type='text' class='smalltextboxStyle' id='updateParamVal'/></td>");
					tr.append("<td class='thstyle'><button class='callButtonStyle' type='button' id='updateButton' onclick='javascript:update("
									+ JSON.stringify(json[i])
									+ ");'>Update</button></td>");
					tr.append("<td class='thstyle'><select class='smallselectStyle' id='callType'>"+											
							+ "<option value='reboot'>Reboot</option>"+
						    + "</select> </td>");
					tr.append("<td class='thstyle'><button class='callButtonStyle' type='button' id='callButton' onclick='javascript:callButton("
							+ JSON.stringify(json[i])
							+ ");'>Call</button></td>");
					$('#table1').append(tr);
				}

			});
		});

		function search() {
			$("#table1").remove();
			paramType = document.deviceForm.paramType.value;
			paramValue = document.deviceForm.paramValue.value;
			//alert("coming " + paramType + "..." + paramValue);
			$
					.getJSON(
							"http://192.168.0.100:8091/devices/filters/imei/XDY2OTE0MDIyNTE2NTkw",
							function(json) {
								console.log(json);
								alert(json);
								var tr;
								for (var i = 0; i < json.length; i++) {
									tr = $('<tr/>');
									tr.append("<td class='thstyle'>" + json[i].id + "</td>");
									tr.append("<td class='thstyle'>" + json[i].assetId + "</td>");
									tr.append("<td class='thstyle'>" + json[i].clientId + "</td>");
									tr.append("<td class='thstyle'>" + json[i].enabled	+ "</td>");
									tr.append("<td class='thstyle'>" + json[i].imei + "</td>");
									tr.append("<td class='thstyle'><select class='smallselectStyle' id='innerparamtype'>"											
											+ "<option value='id'>Device Id</option>"+"</select> </td>");
											
										    
								    
									tr.append("<td class='thstyle'><input type='text' class='smalltextboxStyle' id='updateParamVal'/></td>");
									tr.append("<td class='thstyle'><button class='callButtonStyle' type='button' id='updateButton' onclick='javascript:update("
													+ JSON.stringify(json[i])
													+ ");'>Update</button></td>");
									tr.append("<td class='thstyle'><select class='smallselectStyle' id='callType'>"+											
											+ "<option value='reboot'>Reboot</option>"+
										    + "</select> </td>");
									tr.append("<td class='thstyle'><button class='callButtonStyle' type='button' id='callButton' onclick='javascript:callButton("
											+ JSON.stringify(json[i])
											+ ");'>Call</button></td>");
									
									$('#table2').append(tr);
								}
								return json;
							});
		}

		function update(record) {
			record.enabled = true;
			//alert("update" + JSON.stringify(record));
			$
					.ajax({
						url : 'http://192.168.0.100:8091/devices',
						data : JSON.stringify(record),
						type : 'PATCH',
						contentType : 'application/json',
						xhr : function() {
							return window.XMLHttpRequest == null
									|| new window.XMLHttpRequest().addEventListener == null ? new window.ActiveXObject(
									"Microsoft.XMLHTTP")
									: $.ajaxSettings.xhr();
						}
					});
		}
	</script>

	<div class="divStyle">
		<form:form name="deviceForm">
			<div>
				<select class="selectStyle" id="paramType">
					<option value="">None</option>
					<option value="id">Device Id</option>
					<option value="assetId">Asset Id</option>
					<option value="clientId">Client Id</option>
					<option value="enabled">Enabled</option>
					<option value="imei">IMEI</option>
				</select> 
				<input type="text" class="textboxStyle" id="paramValue" />
				<button class="buttonStyle" type="button" id="searchButton"
					onclick="javascript:search();">Search</button>
				<select class="dropdownStyle" id="dropdown">
					<option value="node">node.js</option>
					<option value="java8">java 1.8</option>
					<option value="java7">java 1.7</option>

				</select>
			</div>
			<br>
			<div>
				<table id="table1" class="tablestyle">
					<tr>
						<th class="thstyle">Device Id</th>
						<th class="thstyle">Asset Id</th>
						<th class="thstyle">Client Id</th>
						<th class="thstyle">Enabled</th>
						<th class="thstyle">IMEI</th>
						<th class="thstyle">Property to update</th>
						<th class="thstyle">Property by value</th>
						<th class="thstyle">Action</th>
						<th class="thstyle">Select method call</th>
						<th class="thstyle">Call Method</th>

					</tr>

				</table>

				<table id="table2" class="tablestyle">
					<tr>
						<th class="thstyle">DeviceId</th>
						<th class="thstyle">Asset Id</th>
						<th class="thstyle">ClientId</th>
						<th class="thstyle">Enabled</th>
						<th class="thstyle">IMEI</th>
						<th class="thstyle">Property to update</th>
						<th class="thstyle">Property by value</th>
						<th class="thstyle">Action</th>
						<th class="thstyle">Select method call</th>
						<th class="thstyle">Call Method</th>

					</tr>

				</table>
			</div>
			<br>
			<div>
				<label for="deviceLog">DeviceLog : </label><br>
				<textarea class="textareastyle" id="deviceLog" name="deviceLogName"></textarea>
			</div>
		</form:form>
	</div>
</body>
</html>
