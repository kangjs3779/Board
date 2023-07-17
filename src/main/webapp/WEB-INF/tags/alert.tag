<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="current" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ attribute name="status"%>

<%--결과를 나타내는 버튼에 id=liveToastBtn 넣기--%>
<%--토스트로 실행 결과 --%>
<c:if test="${not empty message}">
    <div class="alert alert-primary alert-dismissible fade show" role="alert">
            ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<c:if test="${not empty param.message}">
    <div class="alert alert-${status == 'fail' ? 'danger' : 'primary'} alert-dismissible fade show" role="alert">
            ${param.message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>



