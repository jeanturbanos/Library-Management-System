<%@ Page Title="" Language="C#" MasterPageFile="~/LibraryManagementSystem.Master" AutoEventWireup="true" CodeBehind="Membership.aspx.cs" Inherits="LibraryManagementSystem.Member" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style2 {
            margin-top: 0px;
        }
        .auto-style3 {
            height: 30px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <br />

    <br />
    <asp:Label ID="lblMember" runat="server" Font-Bold="True" Font-Size="XX-Large" ForeColor="#996633" Text="Welcome Member"></asp:Label>

    <br />
    <br />
                <asp:Wizard ID="Wizard3" runat="server" ActiveStepIndex="2" BackColor="#F7F6F3" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Yu Gothic UI" Font-Size="Small" Height="244px" Width="908px" ValidateRequestMode="Enabled">
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
                        <asp:WizardStep runat="server" title="Member Information">
                            <br />
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="MemberID" DataSourceID="SqlDataSource1" ForeColor="Black" GridLines="None" AllowPaging="True" OnRowCommand="GridView1_RowCommand">
                                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:CommandField ShowDeleteButton="True" />
                                    <asp:BoundField DataField="MemberID" HeaderText="MemberID" InsertVisible="False" ReadOnly="True" SortExpression="MemberID" />
                                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                    <asp:BoundField DataField="PhoneNumber" HeaderText="PhoneNumber" SortExpression="PhoneNumber" />
                                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                                    <asp:CheckBoxField DataField="Status" HeaderText="Active" SortExpression="Status" />
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
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CSharpClass1ConnectionString %>" DeleteCommand="DELETE FROM [Member] WHERE [MemberID] = @MemberID" InsertCommand="INSERT INTO [Member] ([Name], [PhoneNumber], [Email], [Status]) VALUES (@Name, @PhoneNumber, @Email, @Status)" SelectCommand="SELECT [MemberID], [Name], [PhoneNumber], [Email], [Status] FROM [Member]" UpdateCommand="UPDATE [Member] SET [Name] = @Name, [PhoneNumber] = @PhoneNumber, [Email] = @Email, [Status] = @Status WHERE [MemberID] = @MemberID">
                                <DeleteParameters>
                                    <asp:Parameter Name="MemberID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="Name" Type="String" />
                                    <asp:Parameter Name="PhoneNumber" Type="String" />
                                    <asp:Parameter Name="Email" Type="String" />
                                    <asp:Parameter Name="Status" Type="Boolean" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="Name" Type="String" />
                                    <asp:Parameter Name="PhoneNumber" Type="String" />
                                    <asp:Parameter Name="Email" Type="String" />
                                    <asp:Parameter Name="Status" Type="Boolean" />
                                    <asp:Parameter Name="MemberID" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>
                            <br />
                            <table class="auto-style2">
                                <tr>
                                    <td class="auto-style3">Name:</td>
                                    <td>
                                        <asp:TextBox ID="txtMemberName" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" ControlToValidate="txtMemberName" Display="Dynamic" ErrorMessage="* This field is required" ForeColor="#CC0066"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ControlToValidate="txtMemberName" Display="Dynamic" ErrorMessage="*Please enter valid book title" ForeColor="#660066" ValidationExpression="[a-zA-Z\.\'\-_\s]{1,40}"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3">Password:</td>
                                    <td>
                                        <asp:TextBox ID="txtPassword" type="password" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ControlToValidate="txtPassword" Display="Dynamic" ErrorMessage="* This field is required" ForeColor="#CC0066"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ControlToValidate="txtPassword" Display="Dynamic" ErrorMessage="*Please enter valid book title" ForeColor="#660066" ValidationExpression="[a-zA-Z\.\'\-_\s]{1,40}"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3">Phone</td>
                                    <td class="auto-style3">
                                        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" ControlToValidate="txtPhone" Display="Dynamic" ErrorMessage="* This field is required" ForeColor="#CC0066"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator12" runat="server" ControlToValidate="txtPhone" Display="Dynamic" ErrorMessage="*Please enter valid book title" ForeColor="#660066" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3">Email</td>
                                    <td>
                                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="* This field is required" ForeColor="#CC0066"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator13" runat="server" ControlToValidate="txtEmail" Display="Dynamic" ErrorMessage="*Please enter valid book title" ForeColor="#660066" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:Button ID="btnSave" runat="server" Text="Add" OnClick="btnSave_Click" ForeColor="#7C6F57" />
                                        <asp:Button ID="txtClear" runat="server" Text="Clear" OnClick="txtClear_Click" ForeColor="#7C6F57" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3">
                                        <br />
                                    </td>
                                    <td>
                                        <br />
                                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:WizardStep>
                        <asp:WizardStep runat="server" Title="Search Book">
                            <asp:DropDownList ID="ddlMember" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlMember_SelectedIndexChanged">
                            </asp:DropDownList>
                            <br />
                            Current Date:<asp:LinkButton ID="linkDate" runat="server" OnClick="linkDate_Click">Date</asp:LinkButton>
                            <br />
                            <asp:Calendar ID="calPicker" runat="server" Visible="False" OnSelectionChanged="calPicker_SelectionChanged"></asp:Calendar>
                            <br />
                            <asp:Image ID="Image1" runat="server" Height="71px" Width="119px" />
                            <br />
                            <asp:LinkButton ID="lbChangePicture" runat="server">Change Profile Picture</asp:LinkButton>
                            <br />
                            <br />
                            <br />
                            <asp:DropDownList ID="ddlSearchBy" runat="server">
                                <asp:ListItem Value="Title">Search by Title</asp:ListItem>
                                <asp:ListItem Value="Author">Search by Author</asp:ListItem>
                                <asp:ListItem Value="Publisher">Search by Publisher</asp:ListItem>
                                <asp:ListItem Value="Category">Search by Category</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
                            <br />
                            <asp:GridView ID="bookListingGv" runat="server" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" ForeColor="Black" GridLines="None" OnSelectedIndexChanged="bookListingGv_SelectedIndexChanged">
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
                            Books for reservation:<br />
                            <asp:ListBox ID="lstReservation" runat="server" Width="280px"></asp:ListBox>
                            <br />
                            <asp:Button ID="btnSubmitReservation" runat="server" Text="Submit for Reservation" ForeColor="#7C6F57" OnClick="btnSubmitReservation_Click" />
                            <br />
                            <br />
                            Books Issued to :

                            <br />
                            <asp:ListBox ID="lstReservedBooks" runat="server" Width="309px"></asp:ListBox>
                            <br />
                            Unpaid Over Dues ($5/day) :
                            <asp:Label ID="lblAmountDue" runat="server"></asp:Label>
                            <br />
                            <asp:Button ID="btnExtend" runat="server" OnClick="btnExtend_Click" Text="Extend Books" />
                            <asp:Button ID="txtReturnBooks" runat="server" ForeColor="#7C6F57" OnClick="txtReturnBooks_Click" Text="Return Books" />
                            <br />
                            <br />
                            <br />
                            <br />
                        </asp:WizardStep>
                        <asp:WizardStep runat="server" Title="Member History">
                            <br />
                            History<asp:GridView ID="gvBookListing0" runat="server" AllowPaging="True" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataSourceID="SqlDataSource2" ForeColor="Black" GridLines="None">
                                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                <Columns>
                                    <asp:BoundField DataField="BookID" HeaderText="BookID" SortExpression="BookID" />
                                    <asp:BoundField DataField="BookName" HeaderText="BookName" SortExpression="BookName" />
                                    <asp:BoundField DataField="DateRequested" HeaderText="DateRequested" SortExpression="DateRequested" />
                                    <asp:BoundField DataField="DateReturned" HeaderText="DateReturned" SortExpression="DateReturned" />
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
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:CSharpClass1ConnectionString %>" SelectCommand="SELECT [BookID], [BookName], [DateRequested], [DateReturned] FROM [BookHistory] WHERE (([MemberID] = @MemberID) AND ([DateReturned] IS NOT NULL))">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlMember" Name="MemberID" PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </asp:WizardStep>
                        <asp:WizardStep runat="server" Title="Update Profile">
                            <br />
                            <asp:LinkButton ID="lbChangePassword" runat="server" OnClick="lbChangePassword_Click">Change Password</asp:LinkButton>
                            &nbsp;
                            <asp:LinkButton ID="lbChangeContact" runat="server" OnClick="lbChangeContact_Click">Change Contact</asp:LinkButton>
                            &nbsp;
                            <asp:LinkButton ID="lbDeleteAcctRequest" runat="server" OnClick="lbDeleteAcctRequest_Click">Delete Account Request</asp:LinkButton>
                            <br />
                            <br />
                            <asp:Panel ID="panelNewPwd" runat="server" Visible="False">
                                New Password :
                                <asp:TextBox ID="txtNewPassword" runat="server" type="password"></asp:TextBox>
                                <br />
                                Confirm New Password:
                                <asp:TextBox ID="txtConfirmNewPassword" runat="server" type="password"></asp:TextBox>
                                <br />
                                <br />
                                <asp:Button ID="btnConfirmChangePwd" runat="server" OnClick="btnConfirmChangePwd_Click" Text="Confirm Change Password" />
                            </asp:Panel>
                            <br />
                            <asp:Panel ID="panelNewContact" runat="server" Visible="False">
                                Phone :
                                <asp:TextBox ID="txtNewPhone" runat="server"></asp:TextBox>
                                <br />
                                Email :
                                <asp:TextBox ID="txtNewEmail" runat="server"></asp:TextBox>
                                <br />
                                <br />
                                <asp:Button ID="btnUpdateNewEmail" runat="server" OnClick="btnUpdateNewEmail_Click" Text="Confirm New Contact" />
                            </asp:Panel>
                            <br />
                        </asp:WizardStep>
                    </WizardSteps>
                </asp:Wizard>
    
    <br />

        </asp:Content>
