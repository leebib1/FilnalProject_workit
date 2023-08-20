<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section class="max1920px">
<link href='fullcalendar/main.css' rel='stylesheet' />
<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.8/index.global.min.js'></script>
	<!-- <script>

	document.addEventListener('DOMContentLoaded', function() {
		  var calendarEl = document.getElementById('calendar');

		  var calendar = new FullCalendar.Calendar(calendarEl, {
		    timeZone: 'UTC',
		    initialView: 'resourceTimelineDay',
		    aspectRatio: 1.5,
		    headerToolbar: {
		      left: 'prev,next',
		      center: 'title',
		      right: 'resourceTimelineDay,resourceTimelineWeek,resourceTimelineMonth'
		    },
		    editable: true,
		    resourceAreaHeaderContent: 'Rooms',
		    resources: '/api/demo-feeds/resources.json?with-nesting&with-colors',
		    events: '/api/demo-feeds/events.json?single-day&for-resource-timeline'
		  });

		  calendar.render();
		});

    </script> -->
<script>
	let today=new Date();
	console.log(today);
</script>
	<div class="main-section section-shadow card">
      <div class="right-container">
      	<div id='calendar' class="fc fc-media-screen fc-direction-ltr fc-theme-standard">
      		<div class="fc-header-toolbar fc-toolbar fc-toolbar-ltr">
      			<div class="fc-toolbar-chunk">
      				<div class="fc-button-group">
      					<button type="button" title="Previous day" aria-pressed="false" class="fc-prev-button fc-button fc-button-primary">
      						<span class="fc-icon fc-icon-chevron-left"></span>
      					</button>
      					<button type="button" title="Next day" aria-pressed="false" class="fc-next-button fc-button fc-button-primary">
      						<span class="fc-icon fc-icon-chevron-right"></span>
      					</button>
       				</div>
      			</div>
      			<div class="fc-toolbar-chunk">
      				<h2 class="fc-toolbar-title" id="fc-dom-1">August 7, 2023</h2>
      			</div>
      			<div class="fc-toolbar-chunk">
      				<div class="fc-button-group">
      					<button type="button" title="day view" aria-pressed="true" class="fc-resourceTimelineDay-button fc-button fc-button-primary fc-button-active">day</button>
      					<button type="button" title="week view" aria-pressed="false" class="fc-resourceTimelineWeek-button fc-button fc-button-primary">week</button>
      				</div>
      			</div>
      		</div>
      		
      		<div aria-labelledby="fc-dom-1" class="fc-view-harness fc-view-harness-active" style="height: 627.333px;">
      			<div class="fc-resourceTimelineDay-view fc-view fc-resource-timeline fc-timeline fc-timeline-overlap-enabled">
      				<table role="grid" class="fc-scrollgrid  fc-scrollgrid-liquid">
      					<colgroup>
      						<col style="width: 30%;">
      						<col>
      						<col>
      					</colgroup>
      					<thead role="rowgroup">
      						<tr role="presentation" class="fc-scrollgrid-section fc-scrollgrid-section-header ">
      							<th role="presentation">
      								<div class="fc-scroller-harness">
      									<div class="fc-scroller" style="overflow: hidden;">
      										<table role="presentation" class="fc-datagrid-header fc-scrollgrid-sync-table" style="width: 281px;">
      											<colgroup>
      												<col>
      											</colgroup>
      											<thead role="presentation">
      												<tr role="row">
      													<th role="columnheader" class="fc-datagrid-cell">
      														<div class="fc-datagrid-cell-frame" style="height: 33px;">
      															<div class="fc-datagrid-cell-cushion fc-scrollgrid-sync-inner">
      																<span class="fc-datagrid-expander fc-datagrid-expander-placeholder">
      																	<span class="fc-icon"></span>
      																</span>
      																<span class="fc-datagrid-cell-main">Rooms</span>
      															</div>
      														</div>
      													</th>
      												</tr>
      											</thead>
      										</table>
      									</div>
      								</div>
      							</th>
      							<td role="presentation" class="fc-resource-timeline-divider fc-cell-shaded"></td>
      							<th role="presentation">
      								<div class="fc-scroller-harness">
      									<div class="fc-scroller" style="overflow: scroll; margin-bottom: -17px;">
      										<div class="fc-timeline-header">
      											<table aria-hidden="true" class="fc-scrollgrid-sync-table" style="min-width: 1440px; width: 637px;">
      												<colgroup>
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      												</colgroup>
      												<tbody>
      													<tr class="fc-timeline-header-row fc-timeline-header-row-chrono">
      														<th colspan="2" data-date="2023-08-07T08:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">8am</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T09:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">9am</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T10:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">10am</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T11:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">11am</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T12:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">12pm</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T13:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">1pm</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T14:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">2pm</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T15:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">3pm</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T16:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">4pm</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T17:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">5pm</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T18:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">6pm</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T19:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">7pm</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T20:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">8pm</a>
      															</div>
      														</th>
      														<th colspan="2" data-date="2023-08-07T21:00:00" class="fc-timeline-slot fc-timeline-slot-label fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      															<div class="fc-timeline-slot-frame" style="height: 33px;">
      																<a class="fc-timeline-slot-cushion fc-scrollgrid-sync-inner">9pm</a>
      															</div>
      														</th>
      													</tr>
      												</tbody>
      											</table>
      										</div>
      									</div>
      								</div>
      							</th>
      						</tr>
      					</thead>
      					<tbody role="rowgroup">
      						<tr role="presentation" class="fc-scrollgrid-section fc-scrollgrid-section-body  fc-scrollgrid-section-liquid">
      							<td role="presentation">
      								<div class="fc-scroller-harness fc-scroller-harness-liquid">
      									<div class="fc-scroller fc-scroller-liquid-absolute" style="overflow: scroll; right: -17px;">
      										<table role="presentation" class="fc-datagrid-body fc-scrollgrid-sync-table" style="width: 281px;">
      											<colgroup>
      												<col>
      											</colgroup>
      											<tbody role="presentation">
      											<!-- facility_tb의 fac_no리스트 시작 -->
      												<tr role="row">
      													<td role="gridcell" data-resource-id="a" class="fc-datagrid-cell fc-resource">
      														<div class="fc-datagrid-cell-frame" style="height: 33px;">
      															<div class="fc-datagrid-cell-cushion fc-scrollgrid-sync-inner">
      																<span class="fc-datagrid-expander fc-datagrid-expander-placeholder">
      																	<span class="fc-icon"></span>
      																</span>
      																<span class="fc-datagrid-cell-main">Auditorium A</span>
      															</div>
      														</div>
      													</td>
      												</tr>
      												<tr role="row">
      													<td role="gridcell" data-resource-id="b" class="fc-datagrid-cell fc-resource">
      														<div class="fc-datagrid-cell-frame" style="height: 33px;">
      															<div class="fc-datagrid-cell-cushion fc-scrollgrid-sync-inner">
      																<span class="fc-datagrid-expander fc-datagrid-expander-placeholder">
      																	<span class="fc-icon"></span>
      																</span>
      																<span class="fc-datagrid-cell-main">Auditorium B</span>
      															</div>
      														</div>
      													</td>
      												</tr>
      												<tr role="row">
      													<td role="gridcell" data-resource-id="c" class="fc-datagrid-cell fc-resource">
      														<div class="fc-datagrid-cell-frame" style="height: 33px;">
      															<div class="fc-datagrid-cell-cushion fc-scrollgrid-sync-inner">
      																<span class="fc-datagrid-expander fc-datagrid-expander-placeholder">
      																	<span class="fc-icon"></span>
      																</span>
      																<span class="fc-datagrid-cell-main">Auditorium C</span>
      															</div>
      														</div>
      													</td>
      												</tr>
      												<tr role="row">
      													<td role="gridcell" data-resource-id="d" class="fc-datagrid-cell fc-resource">
      														<div class="fc-datagrid-cell-frame" style="height: 32px;">
      															<div class="fc-datagrid-cell-cushion fc-scrollgrid-sync-inner">
      																<span class="fc-datagrid-expander">
      																	<span class="fc-icon fc-icon-plus-square"></span>
      																</span>
      																<span class="fc-datagrid-cell-main">Auditorium D</span>
      															</div>
      														</div>
      													</td>
      												</tr>
      												<tr role="row">
      													<td role="gridcell" data-resource-id="e" class="fc-datagrid-cell fc-resource">
      														<div class="fc-datagrid-cell-frame" style="height: 33px;">
      															<div class="fc-datagrid-cell-cushion fc-scrollgrid-sync-inner">
      																<span class="fc-datagrid-expander fc-datagrid-expander-placeholder">
      																	<span class="fc-icon"></span>
      																</span>
      																<span class="fc-datagrid-cell-main">Auditorium E</span>
      															</div>
      														</div>
      													</td>
      												</tr>
      												<tr role="row">
      													<td role="gridcell" data-resource-id="f" class="fc-datagrid-cell fc-resource">
      														<div class="fc-datagrid-cell-frame" style="height: 33px;">
      															<div class="fc-datagrid-cell-cushion fc-scrollgrid-sync-inner">
      																<span class="fc-datagrid-expander fc-datagrid-expander-placeholder">
      																	<span class="fc-icon"></span>
      																</span>
      																<span class="fc-datagrid-cell-main">Auditorium F</span>
      															</div>
      														</div>
      													</td>
      												</tr>
      												<!-- facility_tb의 fac_no리스트 끝 -->
      											</tbody>
      										</table>
      									</div>
      								</div>
      							</td>
      							<td role="presentation" class="fc-resource-timeline-divider fc-cell-shaded"></td><!-- 우측 타임라인을 있게하는 코드 -->
      							<td role="presentation">
      								<div class="fc-scroller-harness fc-scroller-harness-liquid">
      									<div class="fc-scroller fc-scroller-liquid-absolute" style="overflow: scroll;">
      										<div class="fc-timeline-body " style="min-width: 1440px;">
      											<div class="fc-timeline-slots"><table aria-hidden="true" class="" style="min-width: 1440px; width: 637px;">
      												<colgroup>
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      													<col style="min-width: 30px;">
      												</colgroup>
      											<tbody>
      												<tr>
      													<td data-date="2023-08-07T08:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T08:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T09:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T09:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T10:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T10:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T11:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T11:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T12:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T12:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T13:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T13:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T14:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T14:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T15:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T15:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T16:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T16:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T17:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T17:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T18:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T18:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T19:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T19:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T20:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T20:30:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-minor fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      													<td data-date="2023-08-07T21:00:00" class="fc-timeline-slot fc-timeline-slot-lane fc-timeline-slot-major fc-slot fc-slot-mon fc-slot-today fc-slot-future">
      														<div></div>
      													</td>
      												</tr>
      											</tbody>
      										</table>
      									</div>
      									<div class="fc-timeline-bg"></div>
      									<table aria-hidden="true" class="fc-scrollgrid-sync-table " style="min-width: 1440px; width: 637px;">
      										<tbody>
      											<!-- room A의 이벤트 표시 -->
      											<tr>
      												<td data-resource-id="a" class="fc-timeline-lane fc-resource">
      													<div class="fc-timeline-lane-frame" style="height: 33px;">
      														<div class="fc-timeline-lane-misc"></div>
      														<div class="fc-timeline-bg"></div>
      														<div class="fc-timeline-events fc-scrollgrid-sync-inner" style="height: 0px;"></div>
      													</div>
      												</td>
      											</tr>
      											<!-- room B의 이벤트 표시 -->
      											<tr>
      												<td data-resource-id="b" class="fc-timeline-lane fc-resource">
      													<div class="fc-timeline-lane-frame" style="height: 33px;">
      														<div class="fc-timeline-lane-misc"></div>
      														<div class="fc-timeline-bg"></div>
      														<div class="fc-timeline-events fc-scrollgrid-sync-inner" style="height: 21px;">
      															<div class="fc-timeline-event-harness" style="top: 0px; left: 600px; right: -900px;">
      																<a class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today fc-event-future fc-timeline-event fc-h-event" style="border-color: green; background-color: green;">
      																	<div class="fc-event-main">
      																		<div class="fc-event-main-frame">
      																			<div class="fc-event-title-container">
      																				<div class="fc-event-title fc-sticky" style="top: 0px;">event 5</div>
      																			</div>
      																		</div>
      																	</div>
      																	<div class="fc-event-resizer fc-event-resizer-start"></div>
      																	<div class="fc-event-resizer fc-event-resizer-end"></div>
      																</a>
      															</div>
      														</div>
      													</div>
      												</td>
      											</tr>
      											<!-- room C의 이벤트 표시 -->
      											<tr>
      												<td data-resource-id="c" class="fc-timeline-lane fc-resource">
      													<div class="fc-timeline-lane-frame" style="height: 33px;">
      														<div class="fc-timeline-lane-misc"></div>
      														<div class="fc-timeline-bg"></div>
      														<div class="fc-timeline-events fc-scrollgrid-sync-inner" style="height: 21px;">
      															<div class="fc-timeline-event-harness" style="top: 0px; left: 720px; right: -1440px;">
      																<a class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-today fc-event-future fc-timeline-event fc-h-event" style="border-color: orange; background-color: orange;">
      																	<div class="fc-event-main">
      																		<div class="fc-event-main-frame">
      																			<div class="fc-event-title-container">
      																				<div class="fc-event-title fc-sticky" style="top: 0px;">event 3</div>
      																			</div>
      																		</div>
      																	</div>
      																	<div class="fc-event-resizer fc-event-resizer-start"></div>
      																</a>
      															</div>
      														</div>
      													</div>
      												</td>
      											</tr>
      											<!-- room D의 이벤트 표시 -->
      											<tr>
      												<td data-resource-id="d" class="fc-timeline-lane fc-resource">
      													<div class="fc-timeline-lane-frame" style="height: 32px;">
      														<div class="fc-timeline-lane-misc"></div>
      														<div class="fc-timeline-bg"></div>
      														<div class="fc-timeline-events fc-scrollgrid-sync-inner" style="height: 21px;">
      															<div class="fc-timeline-event-harness" style="top: 0px; left: 0px; right: -1440px;">
      																<a class="fc-event fc-event-draggable fc-event-resizable fc-event-end fc-event-today fc-timeline-event fc-h-event">
      																	<div class="fc-event-main">
      																		<div class="fc-event-main-frame">
      																			<div class="fc-event-title-container">
      																				<div class="fc-event-title fc-sticky" style="top: 0px;">event 1</div>
      																			</div>
      																		</div>
      																	</div>
      																	<div class="fc-event-resizer fc-event-resizer-end"></div>
      																</a>
      															</div>
      														</div>
      													</div>
      												</td>
      											</tr>
      											<!-- room E의 이벤트 표시 -->
      											<tr>
      												<td data-resource-id="e" class="fc-timeline-lane fc-resource">
      													<div class="fc-timeline-lane-frame" style="height: 33px;">
      														<div class="fc-timeline-lane-misc"></div>
      														<div class="fc-timeline-bg"></div>
      														<div class="fc-timeline-events fc-scrollgrid-sync-inner" style="height: 21px;">
      															<div class="fc-timeline-event-harness" style="top: 0px; left: 540px; right: -840px;">
      																<a class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today fc-event-future fc-timeline-event fc-h-event">
      																	<div class="fc-event-main">
      																		<div class="fc-event-main-frame">
      																			<div class="fc-event-title-container">
      																				<div class="fc-event-title fc-sticky" style="top: 0px;">event 2</div>
      																			</div>
      																		</div>
      																	</div>
      																	<div class="fc-event-resizer fc-event-resizer-start"></div>
      																	<div class="fc-event-resizer fc-event-resizer-end"></div>
      																</a>
      															</div>
      														</div>
      													</div>
      												</td>
      											</tr>
      											<!-- room F의 이벤트 표시 -->
      											<tr>
      												<td data-resource-id="f" class="fc-timeline-lane fc-resource">
      													<div class="fc-timeline-lane-frame" style="height: 33px;">
      														<div class="fc-timeline-lane-misc"></div>
      														<div class="fc-timeline-bg"></div>
      														<div class="fc-timeline-events fc-scrollgrid-sync-inner" style="height: 21px;">
      															<div class="fc-timeline-event-harness" style="top: 0px; left: 450px; right: -570px;">
      																<a class="fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today fc-event-future fc-timeline-event fc-h-event" style="border-color: red; background-color: red;">
      																	<div class="fc-event-main">
      																		<div class="fc-event-main-frame">
      																			<div class="fc-event-title-container">
      																				<div class="fc-event-title fc-sticky" style="top: 0px;">event 4</div>
      																			</div>
      																		</div>
      																	</div>
      																	<div class="fc-event-resizer fc-event-resizer-start"></div>
      																	<div class="fc-event-resizer fc-event-resizer-end"></div>
      																</a>
      															</div>
      														</div>
      													</div>
      												</td>
      											</tr>
      										</tbody>
      									</table>
      								</div>
      							</div>
      						</div>
      					</td>
      				</tr>
      			</tbody>
      		</table>
      	</div>
      </div>
      	</div>
      </div>
     </div>
</section>
</body>
</html>