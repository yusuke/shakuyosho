<!DOCTYPE html>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<tag:skelton title="借用証ジェネレータ">
    <tag:loggedin>
        <div id="tweeted" class="alert alert-success fade in" style="display:none">
            <a class="close" data-dismiss="alert">x</a>
            ツイートしました！
        </div>

        <div id="tweetform" style="display:none">
            借用証を画像付きでツイートしよう！
            <form action="./post" method="post" class="form-vertical">
                <textarea style="width:300px" rows="3" name="text" id="tweetText"></textarea><br>
                <input type="hidden" name="from" id="from"/>
                <input type="hidden" name="to" id="to"/>
                <input type="hidden" name="amount" id="amount"/>
                <input type="button" name="button" value="ツイート" onclick="tweet()" class="btn"/>
            </form>
        </div>
        <script>
            function tweet() {
                $.ajax({
                    type: 'post',
                    url: './post',
                    data: {
                        'text': $("#tweetText").val(),
                        'to': $("#to").val(),
                        'from': $("#from").val(),
                        'amount': $("#amount").val()
                    },
                    success: function (data) {
                        $("#tweeted").show();
                        $("#tweetform").hide();
                    }
                });

            }
        </script>
        <c:if test="${!empty from}">

            <script language="JavaScript">
                $("#tweetform").show();
                var tweetText = ".@${to} は @${from} に ${amount} 円借金しています #借用証 http://deathmar.ch/shakuyosho/shakuyo${requestScope['javax.servlet.forward.path_info']} ";
                $("#tweetText").html(tweetText);
                $("#from").val("${from}");
                $("#to").val("${to}");
                $("#amount").val("${amount}");
            </script>
        </c:if>
    </tag:loggedin>
    <c:if test="${!empty from}">
        <img src="generated/${from}/${to}/${amount}.gif"/><br>
    </c:if>


    <hr width="300px">
    <form>

    </form>

</tag:skelton>