<%--
  Created by IntelliJ IDEA.
  User: joe
  Date: 2018/10/11
  Time: 下午 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="crawler.crawler" %>
<%@ page import="org.json.*" %>
<html>
<head>
    <title>玉山銀行-歷史匯率走勢圖</title>
    <script
            src="http://code.jquery.com/jquery-3.3.1.js"
            integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
            crossorigin="anonymous"></script>
    <link href="bootstrap-4.1.3-dist/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="bootstrap-4.1.3-dist/js/bootstrap.min.js"></script>
    <link href="home.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>


</head>
<body>
<%JSONArray result1 = crawler.getRate("USD", "美元(USD)");%>
<%JSONArray result2 = crawler.getRate("CNY", "人民幣(CNY)");%>
<%JSONArray result3 = crawler.getRate("EUR", "歐元(EUR)");%>
<%JSONArray result4 = crawler.getRate("JPY", "日幣(JPY)");%>
<%JSONArray result5 = crawler.getRate("HKD", "港幣(HKD)");%>
<%JSONArray result6 = crawler.getRate("AUD", "澳幣(AUD)");%>

<script type="text/javascript">
    const result1 = JSON.stringify(<%=result1%>);
    const result2 = JSON.stringify(<%=result2%>);
    const result3 = JSON.stringify(<%=result3%>);
    const result4 = JSON.stringify(<%=result4%>);
    const result5 = JSON.stringify(<%=result5%>);
    const result6 = JSON.stringify(<%=result6%>);


    const crawler_datas = [JSON.parse(result1), JSON.parse(result2), JSON.parse(result3)
        , JSON.parse(result4), JSON.parse(result5), JSON.parse(result6)];


    function getPlotData(crawler_data) {
        const time = [];
        const sell_rate = [];
        const buy_rate = [];

        for (let i = 0; i < crawler_data.length; i++) {
            time.push(crawler_data[i].Time);
            sell_rate.push(crawler_data[i].SellRate);
            buy_rate.push(crawler_data[i].BuyRate);
        }
        return [time, sell_rate, buy_rate];
    }

</script>

<h1 class="text-center">玉山銀行-歷史匯率走勢圖</h1>


<div class="container">
    <div class="row">

        <!--team-1-->
        <div class="col-lg-4">
            <div class="our-team-main">

                <div class="team-front">
                    <img src="http://placehold.it/110x110/9c27b0/fff?text=USD" class="img-fluid"/>
                    <h3>台幣-美元匯率</h3>
                    <p>USD/TWD</p>
                </div>

                <div class="team-back">
                    <canvas id="myChart1" class="mychart" width="290" height="185"></canvas>
                </div>

            </div>
        </div>
        <!--team-1-->

        <!--team-2-->
        <div class="col-lg-4">
            <div class="our-team-main">

                <div class="team-front">
                    <img src="http://placehold.it/110x110/336699/fff?text=CNY" class="img-fluid"/>
                    <h3>台幣-人民幣匯率</h3>
                    <p>CNY/TWD</p>
                </div>

                <div class="team-back">
                    <canvas id="myChart2" class="mychart" width="290" height="185"></canvas>
                </div>

            </div>
        </div>
        <!--team-2-->

        <!--team-3-->
        <div class="col-lg-4">
            <div class="our-team-main">

                <div class="team-front">
                    <img src="http://placehold.it/110x110/607d8b/fff?text=EUR" class="img-fluid"/>
                    <h3>台幣-歐元匯率</h3>
                    <p>EUR/TWD</p>
                </div>

                <div class="team-back">
                    <canvas id="myChart3" class="mychart" width="290" height="185"></canvas>
                </div>

            </div>
        </div>
        <!--team-3-->

        <!--team-4-->
        <div class="col-lg-4">
            <div class="our-team-main">

                <div class="team-front">
                    <img src="http://placehold.it/110x110/4caf50/fff?text=JPY" class="img-fluid"/>
                    <h3>台幣-日幣匯率</h3>
                    <p>JPY/TWD</p>
                </div>

                <div class="team-back">
                    <canvas id="myChart4" class="mychart" width="290" height="185"></canvas>
                </div>

            </div>
        </div>
        <!--team-4-->

        <!--team-5-->
        <div class="col-lg-4">
            <div class="our-team-main">

                <div class="team-front">
                    <img src="http://placehold.it/110x110/e91e63/fff?text=HKD" class="img-fluid"/>
                    <h3>台幣-港幣匯率</h3>
                    <p>HKD/TWD</p>
                </div>

                <div class="team-back">
                    <canvas id="myChart5" class="mychart" width="290" height="185"></canvas>
                </div>

            </div>
        </div>
        <!--team-5-->

        <!--team-6-->
        <div class="col-lg-4">
            <div class="our-team-main">

                <div class="team-front">
                    <img src="http://placehold.it/110x110/2196f3/fff?text=AUD" class="img-fluid"/>
                    <h3>台幣-澳幣匯率</h3>
                    <p>AUD/TWD</p>
                </div>

                <div class="team-back">
                    <canvas id="myChart6" class="mychart" width="290" height="185"></canvas>
                </div>

            </div>
        </div>
        <!--team-6-->


    </div>
</div>


</body>
<script>

    for (let i = 1; i < 7; i++) {
        // Get the context of the canvas element we want to select
        const ctx = document.getElementById("myChart" + i).getContext("2d");
        // Instantiate a new chart using 'data' (defined below)
        console.log(getPlotData(crawler_datas[i-1]));
        const myLineChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: getPlotData(crawler_datas[i-1])[0],
                datasets: [
                    {
                        label: "賣匯",
                        pointHoverBorderColor: "#ff7224",
                        pointHoverBackgroundColor: "#ce27ff",
                        pointBorderColor: "#ff7224",
                        pointBackgroundColor: "#ff7224",
                        borderColor: "#ff7224",
                        data: getPlotData(crawler_datas[i-1])[1]
                    },
                    {
                        label: "買匯",
                        pointHoverBorderColor: "#15ff0f",
                        pointHoverBackgroundColor: "#ce27ff",
                        pointBorderColor: "#15ff0f",
                        pointBackgroundColor: "#15ff0f",
                        borderColor: "#15ff0f",
                        data: getPlotData(crawler_datas[i-1])[2]
                    }
                ]
            }
        });
    }

</script>
</html>
