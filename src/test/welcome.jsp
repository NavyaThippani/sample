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
<link href="css/home.css" rel="stylesheet" type="text/css" />
</head>
<body background="images/plain-gray-background.jpg">
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
