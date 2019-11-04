<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManagementSystem.Master" AutoEventWireup="true" CodeBehind="Librarian.aspx.cs" Inherits="LibraryManagementSystem.Librarian" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <br />
    <asp:Label ID="lblLibrarian" runat="server" Font-Bold="True" Font-Size="XX-Large" ForeColor="#996633" Text="Welcome Librarian"></asp:Label>
    <br />
    <br />    
                <asp:Wizard ID="Wizard3" runat="server" ActiveStepIndex="0" BackColor="#F7F6F3" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Yu Gothic UI" Font-Size="Small" Height="244px" Width="840px" ValidateRequestMode="Enabled">
                    <FinishNavigationTemplate>
                        <asp:Button ID="FinishPreviousButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="MovePrevious" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" Text="Previous" />
                        <asp:Button ID="FinishButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" CommandName="MoveComplete" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" Text="Finish" />
                    </FinishNavigationTemplate>
                    <HeaderStyle BackColor="#5D7B9D" BorderStyle="Solid" Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Left" />
                    <NavigationButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
                    <SideBarButtonStyle ForeColor="White" BorderWidth="0px" Font-Names="Verdana" />
                    <SideBarStyle BackColor="#7C6F57" Font-Size="0.9em" VerticalAlign="Top" BorderWidth="0px" />
                    <StartNavigationTemplate>
                        <asp:Button ID="StartNextButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" CommandName="MoveNext" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" Text="Next" />
                    </StartNavigationTemplate>
                    <StepStyle BorderWidth="0px" ForeColor="#5D7B9D" />
                    <WizardSteps>
                        <asp:WizardStep runat="server" title="HOME">
                          <h1> .NET C LIBRARY</h1>  
                        </asp:WizardStep>
                        <asp:WizardStep runat="server" Title="Book Information">
                            Current Date:<asp:LinkButton ID="linkDate" runat="server" OnClick="linkDate_Click">Date</asp:LinkButton>
                            <asp:Calendar ID="calPicker" runat="server" OnSelectionChanged="calPicker_SelectionChanged" Visible="False"></asp:Calendar>
                            <br />
                            <br />
                            View book report:<br />
                            <asp:DropDownList ID="ddlSearchBy" runat="server">
                                <asp:ListItem Value="Title">Search by Title</asp:ListItem>
                                <asp:ListItem Value="Author">Search by Author</asp:ListItem>
                                <asp:ListItem Value="Publisher">Search by Publisher</asp:ListItem>
                                <asp:ListItem Value="Category">Search by Category</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                            <asp:GridView ID="bookListingGv" runat="server" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
                                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                <FooterStyle BackColor="Tan" />
                                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                                <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                                <SortedAscendingCellStyle BackColor="#FAFAE7" />
                                <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                                <SortedDescendingCellStyle BackColor="#E1DB9C" />
                                <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                            </asp:GridView>
                            <br />
                            <br />
                            <br />
                            View issued and overdue book:<br />
                            <br />
                            <br />
                            <asp:DropDownList ID="ddlReportOptions" runat="server">
                                <asp:ListItem Value="Issued">Issued books</asp:ListItem>
                                <asp:ListItem Value="Overdue">Overdue books</asp:ListItem>
                            </asp:DropDownList>
                            <asp:Button ID="btnGenerateReport" runat="server" OnClick="btnGenerateReport_Click" Text="Generate Report" />
                            <br />
                            <asp:GridView ID="reportListingGv" runat="server" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None">
                                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                <FooterStyle BackColor="Tan" />
                                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                                <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                                <SortedAscendingCellStyle BackColor="#FAFAE7" />
                                <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                                <SortedDescendingCellStyle BackColor="#E1DB9C" />
                                <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                            </asp:GridView>
                            <br />
                            <br />
                            <br />
                            <br />
                        </asp:WizardStep>
                    </WizardSteps>
                </asp:Wizard>
    
    <br />
    <br />

</asp:Content>
