<html>
<body>

  <form runat="server">

      <h3><font face="verdana">Applying Styles to Web Controls</font></h3>

      <p><font face="verdana"><h4>Style Sub-Properties</h4></font><p>

      <ASP:Calendar id="MyCalendar" runat="server"

           BackColor="Beige"
           ForeColor="Blue"
           BorderWidth="3"
           BorderStyle="Solid"
           BorderColor="Black"
           Height="450"
           Width="450"
           Font-Size="12pt"
           Font-Name="Tahoma,Arial"
           Font-Underline="false"
           CellSpacing=2
           CellPadding=2
           ShowGridLines=true
       >

           <TitleStyle BorderColor="darkolivegreen" BorderWidth="3" BackColor="olivedrab" Height="50px" />

           <DayHeaderStyle BorderColor="darkolivegreen" BorderWidth="3" BackColor="orange" ForeColor="black" Height="20px" />

           <WeekEndDayStyle BackColor="palegoldenrod" Width="50px" Height="50px" />

           <DayStyle Width="50px" Height="50px" />

           <TodayDayStyle BorderWidth="3" />

           <SelectedDayStyle BorderColor="firebrick" BorderWidth="3" />

           <OtherMonthDayStyle Width="50px" Height="50px" />

       </ASP:Calendar>

    </form>

</body>
</html>
