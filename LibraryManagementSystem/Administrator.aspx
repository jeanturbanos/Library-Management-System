<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManagementSystem.Master" AutoEventWireup="true" CodeBehind="Administrator.aspx.cs" Inherits="LibraryManagementSystem.Administrator" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            height: 30px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                <br />
                <br />
                <asp:Label ID="lblAdministrator" runat="server" Font-Size="XX-Large" ForeColor="#996633" Text="Welcome Administrator" Font-Bold="True"></asp:Label>
                <br />
                <br />
                <asp:Wizard ID="Wizard3" runat="server" ActiveStepIndex="0" BackColor="#F7F6F3" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Yu Gothic UI" Font-Size="Small" Height="244px" Width="840px">
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
                          <h1> &nbsp;.NET C LIBRARY </h1>  
                        </asp:WizardStep>
                        <asp:WizardStep runat="server" title="Book Information">
                            <br />
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="BookID" DataSourceID="SqlDataSource2" ForeColor="Black" GridLines="None" AllowPaging="True" OnRowCommand="GridView1_RowCommand">
                                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:CommandField ShowDeleteButton="True" />
                                    <asp:BoundField DataField="BookID" HeaderText="BookID" InsertVisible="False" ReadOnly="True" SortExpression="BookID" />
                                    <asp:BoundField DataField="Book" HeaderText="Book" SortExpression="Book" />
                                    <asp:BoundField DataField="Author" HeaderText="Author" SortExpression="Author" />
                                    <asp:BoundField DataField="Publisher" HeaderText="Publisher" SortExpression="Publisher" />
                                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                                    <asp:BoundField DataField="Copies" HeaderText="Copies" SortExpression="Copies" />
                                    <asp:CommandField />
                                </Columns>
                                <FooterStyle BackColor="Tan" />
                                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                                <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                                <SortedAscendingCellStyle BackColor="#FAFAE7" />
                                <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                                <SortedDescendingCellStyle BackColor="#E1DB9C" />
                                <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CSharpClass1ConnectionString %>" DeleteCommand="DELETE FROM [Book] WHERE [BookID] = @BookID" InsertCommand="INSERT INTO [Book] ([Book], [Author], [Publisher], [Category], [Copies]) VALUES (@Book, @Author, @Publisher, @Category, @Copies)" SelectCommand="SELECT * FROM [Book]" UpdateCommand="UPDATE [Book] SET [Book] = @Book, [Author] = @Author, [Publisher] = @Publisher, [Category] = @Category, [Copies] = @Copies WHERE [BookID] = @BookID">
                                <DeleteParameters>
                                    <asp:Parameter Name="BookID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="Book" Type="String" />
                                    <asp:Parameter Name="Author" Type="String" />
                                    <asp:Parameter Name="Publisher" Type="String" />
                                    <asp:Parameter Name="Category" Type="String" />
                                    <asp:Parameter Name="Copies" Type="Int32" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Book" Type="String" />
                                    <asp:Parameter Name="Author" Type="String" />
                                    <asp:Parameter Name="Publisher" Type="String" />
                                    <asp:Parameter Name="Category" Type="String" />
                                    <asp:Parameter Name="Copies" Type="Int32" />
                                    <asp:Parameter Name="BookID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <br />
                            <table class="auto-style2">
                                <tr>
                                    <td class="auto-style2">Book:</td>
                                    <td class="auto-style2">
                                        <asp:TextBox ID="txtTitleBook" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="txtTitleBook" Display="Dynamic" ErrorMessage="* This field is required" ForeColor="#CC0066"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ControlToValidate="txtTitleBook" Display="Dynamic" ErrorMessage="*Please enter valid book title" ForeColor="#660066" ValidationExpression="[a-zA-Z\.\'\-_\s]{1,40}"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3">Author:</td>
                                    <td>
                                        <asp:TextBox ID="txtAuthor" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ControlToValidate="txtAuthor" Display="Dynamic" ErrorMessage="* This field is required" ForeColor="#CC0066"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ControlToValidate="txtAuthor" Display="Dynamic" ErrorMessage="*Please enter valid book title" ForeColor="#660066" ValidationExpression="[a-zA-Z\.\'\-_\s]{1,40}"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3">Publisher</td>
                                    <td>
                                        <asp:TextBox ID="txtPublisher" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ControlToValidate="txtPublisher" Display="Dynamic" ErrorMessage="* This field is required" ForeColor="#CC0066"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server" ControlToValidate="txtPublisher" Display="Dynamic" ErrorMessage="*Please enter valid book title" ForeColor="#660066" ValidationExpression="[a-zA-Z\.\'\-_\s]{1,40}"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3">Category</td>
                                    <td>
                                        <asp:TextBox ID="txtBkCategory" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ControlToValidate="txtBkCategory" Display="Dynamic" ErrorMessage="* This field is required" ForeColor="#CC0066"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server" ControlToValidate="txtBkCategory" Display="Dynamic" ErrorMessage="*Please enter valid book title" ForeColor="#660066" ValidationExpression="[a-zA-Z\.\'\-_\s]{1,40}"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3">Copies:</td>
                                    <td>
                                        <asp:TextBox ID="txtCopies" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ControlToValidate="txtCopies" Display="Dynamic" ErrorMessage="* This field is required" ForeColor="#CC0066"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator14" runat="server" ControlToValidate="txtCopies" Display="Dynamic" ErrorMessage="*Please enter valid number" ForeColor="#660066" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3">&nbsp;</td>
                                    <td>
                                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="Add" />
                                        &nbsp;<asp:Button ID="btnClear" runat="server" OnClick="btnClear_Click1" Text="Clear" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3">
                                        <br />
                                    </td>
                                    <td>
                                        &nbsp; &nbsp;
                                        <br />
                                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:WizardStep>
                        <asp:WizardStep runat="server" Title="Member Requests">
                            <br />
                            Account Deletion Request<br />
                            <asp:GridView ID="gvMemberRequest" runat="server" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" OnRowCommand="gvMemberRequest_RowCommand" >
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
                        </asp:WizardStep>
                    </WizardSteps>
                </asp:Wizard>
    <br />
</asp:Content>
