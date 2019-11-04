using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryManagementSystem
{
    public partial class Member : System.Web.UI.Page
    {
        //create object of DataSet1.xsd
        private DataSet1 ds1 = new DataSet1();

        //create the object of the table Adapters
        DataSet1TableAdapters.MemberTableAdapter taMember;
        DataSet1TableAdapters.BookTableAdapter taBook;
        DataSet1TableAdapters.BookHistoryTableAdapter taBookHistory;

        private static int updateID = 0;
        DataTable dt;
        DataColumn dc;

        protected void Page_Load(object sender, EventArgs e)
        {
            taMember = new DataSet1TableAdapters.MemberTableAdapter();
            taBook = new DataSet1TableAdapters.BookTableAdapter();
            taBookHistory = new DataSet1TableAdapters.BookHistoryTableAdapter();

            if (Page.IsPostBack == false)
            {
                this.PopulateBook();
                this.PopulateMember();
                this.DisplayCurrentDate();
                this.LoadReservedBooks();
                this.CalculateOverdue();
            }           


        }
        
        private void PopulateMember()
        {            
            taMember.Fill(ds1.Member);            

            foreach (DataRow dr in ds1.Member.Rows)
            {
                ddlMember.Items.Add(new ListItem(dr["Name"].ToString(), dr["MemberID"].ToString()));
            }
            //ddlMember.Items.Add()
        }

        private void DisplayCurrentDate()
        {
            linkDate.Text = DateTime.Now.ToShortDateString();
        }

        private void PopulateBook()
        {
            taBook.Fill(ds1.Book);

            dt = new DataTable();

            CommandField selectCommandField = new CommandField();
            selectCommandField.ShowSelectButton = true;
            selectCommandField.SelectText = "Reserve";
            bookListingGv.Columns.Add(selectCommandField);

            dt.Columns.Add(new DataColumn("Book Id", typeof(string)));
            dt.Columns.Add(new DataColumn("Book", typeof(string)));
            dt.Columns.Add(new DataColumn("Author", typeof(string)));
            dt.Columns.Add(new DataColumn("Publisher", typeof(string)));
            dt.Columns.Add(new DataColumn("Category", typeof(string)));
            
            DataRow drTemp;
            foreach (DataRow dr in ds1.Book.Rows)
            {
                drTemp = dt.NewRow();
                drTemp[0] = dr["BookID"].ToString();
                drTemp[1] = dr["Book"].ToString();
                drTemp[2] = dr["Author"].ToString();
                drTemp[3] = dr["Publisher"].ToString();
                drTemp[4] = dr["Category"].ToString();
                dt.Rows.Add(drTemp);
            }

            bookListingGv.DataSource = dt;
            bookListingGv.DataBind();

            
        }

        private void LoadReservedBooks()
        {
            taMember.Fill(ds1.Member);

            taBookHistory.Fill(ds1.BookHistory);
            DataView dvBookHistory = ds1.BookHistory.DefaultView;
            dvBookHistory.RowFilter = "MemberID = " + Convert.ToInt32(this.ddlMember.Text) + " AND DateReturned IS NULL ";
            foreach (DataRowView dRowView in dvBookHistory)
            {
                lstReservedBooks.Items.Add(new ListItem(dRowView[2].ToString(), dRowView[1].ToString()));
            }
        }

        private void PromptMessage(string message)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + message + "')", true);
        }
        
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //CommandName is property to find which  Commmand Field has been clicked by user
            if (e.CommandName == "Select")
            {

                //ADD VALIDATION based on Issue Limit and Books available
                bool allowBorrow = false;


                // Select the row which is clicked by the user
                GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];

                txtMemberName.Text = row.Cells[3].Text;
                txtPassword.Text = "xxxxxxxxxx";
                txtPhone.Text = row.Cells[4].Text;
                txtEmail.Text = row.Cells[5].Text;
                updateID = Convert.ToInt16(row.Cells[2].Text);
                this.btnSave.Text = "Update";

                
            }

            if (e.CommandName == "Delete")
            {
                GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
                taMember.Fill(ds1.Member);

                DataRow[] dr = ds1.Member.Select("MemberID=" + row.Cells[2].Text);
                dr[0].Delete();

                taMember.Update(ds1.Member);
                GridView1.DataBind();
            }

        }

        protected void DropDownList1_SelectedIndexChanged1(object sender, EventArgs e)
        {
            //MultiView1.ActiveViewIndex = DropDownList1.SelectedIndex;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (updateID == 0)
            {
                taMember.Fill(ds1.Member);
                DataView dvMember = ds1.Member.DefaultView;
                dvMember.RowFilter = "Name = '" + txtMemberName.Text + "' ";
                if (dvMember.Count == 0)
                {
                    DataSet1.MemberRow row = ds1.Member.NewMemberRow();

                    row.Name = txtMemberName.Text;
                    //Hash or encrypt password
                    row.Password = txtPassword.Text;
                    row.PhoneNumber = txtPhone.Text;
                    row.Email = txtEmail.Text;
                    row.Picture = " ";
                    row.BorrowLimit = 5;
                    row.RepeatLimit = 3;
                    row.Status = true;

                    ds1.Member.Rows.Add(row);
                    taMember.Update(ds1.Member);
                    GridView1.DataBind();

                    ClearFiels();

                    lblMessage.Text = "Member added successfully";
                   

                    //PopulateMember();

                }
                else
                {
                    lblMessage.Text = "Member already exists";
                    txtMemberName.Focus();
                }
            }
            else if (updateID > 0)
            {
                taMember.Fill(ds1.Member);

                DataRow[] dr = ds1.Member.Select("MemberID=" + updateID);

                dr[0]["Name"] = txtMemberName.Text;
                dr[0]["PhoneNumber"] = txtPhone.Text;
                dr[0]["Email"] = txtEmail.Text;

                taMember.Update(ds1.Member);
                GridView1.DataBind();

                ClearFiels();

            }
        }

        protected void txtClear_Click(object sender, EventArgs e)
        {
            updateID = 0;
            ClearFiels();
            txtMemberName.Focus();
            btnSave.Text = "Add";

        }

        private void ClearFiels()
        {
            txtMemberName.Text = "";
            txtPassword.Text = "";
            txtPhone.Text = "";
            txtEmail.Text = "";
        }

        protected void bookListingGv_SelectedIndexChanged(object sender, EventArgs e)
        {
            string bookId = bookListingGv.SelectedRow.Cells[1].Text;
            string bookName = bookListingGv.SelectedRow.Cells[2].Text;

            //Check list before adding

            bool allowBorrow = true;
            string errorMessage = "";
            
            //Check Borrow Limit
            taMember.Fill(ds1.Member);
            if(lstReservation.Items.Count >= Convert.ToInt32(ds1.Member.Select("MemberID=" + Convert.ToInt32(this.MeMember.Text))[0]["BorrowLimit"]))
            {
                allowBorrow = false;
                errorMessage = "Exceeded borrow limit.";
            }

            //Check Repeat Limit
            taBookHistory.Fill(ds1.BookHistory);
            if(ds1.BookHistory.Select("MemberID=" + Convert.ToInt32(this.ddlMember.Text) + " AND BookID=" + bookId).Length >= Convert.ToInt32(ds1.Member.Select("MemberID=" + Convert.ToInt32(this.ddlMember.Text))[0]["RepeatLimit"]))
            {
                allowBorrow = false;
                errorMessage = "Exceeded repeat limit for the selected book.";
            }

            //Check book availability
            taBook.Fill(ds1.Book);
            DataRow[] dRows = ds1.Book.Select("BookID=" + bookId);
            if (dRows.Length > 0)
            {
                if (Convert.ToInt32(dRows[0]["Copies"].ToString()) - GetTotalReservedBooks(Convert.ToInt32(bookId)) <= 0)
                {
                    allowBorrow = false;
                    errorMessage = "No available book";
                }
            }

            if (allowBorrow)
            {
                lstReservation.Items.Add(new ListItem(bookName, bookId));
            }
            else
            {
                this.PromptMessage(errorMessage);
            }
        }

        private Int32 GetTotalReservedBooks(int bookId)
        {
            taBookHistory.Fill(ds1.BookHistory);
        
            return ds1.BookHistory.Select("BookID=" + bookId + " AND DateReturned IS NULL").Length;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            taBook.Fill(ds1.Book);
            dt = ds1.Book;
            DataView dv = dt.DefaultView;
            switch (this.ddlSearchBy.Text)
            {
                case "Title":
                    dv.RowFilter = "Book LIKE '%" + txtSearch.Text + "%' ";
                    break;
                case "Author": 
                    dv.RowFilter = "Author LIKE '%" + txtSearch.Text + "%' ";
                    break;
                case "Publisher": 
                    dv.RowFilter = "Publisher LIKE '%" + txtSearch.Text + "%' ";
                    break;
                case "Category":
                    dv.RowFilter = "Category LIKE '%" + txtSearch.Text + "%' ";
                    break;
                default: dv.RowFilter = "";
                    break;
            }
            
            bookListingGv.DataSource = dv;
            bookListingGv.DataBind();
        }

        protected void btnSubmitReservation_Click(object sender, EventArgs e)
        {
            taBookHistory.Fill(ds1.BookHistory);
            DataView dvBookHistory = ds1.BookHistory.DefaultView;
            DataSet1.BookHistoryRow bhRow;
            foreach (ListItem li in lstReservation.Items)
            {
                bhRow = ds1.BookHistory.NewBookHistoryRow();
                bhRow.BookID = Convert.ToInt32(li.Value);
                bhRow.BookName = li.Text;
                bhRow.MemberID = Convert.ToInt32(ddlMember.Text);
                bhRow.MemberName = ddlMember.SelectedItem.Text;
                bhRow.Status = false;
                bhRow.DateRequested = DateTime.ParseExact(this.linkDate.Text, "yyyy-MM-dd", null);

                ds1.BookHistory.Rows.Add(bhRow);
                taBookHistory.Update(ds1.BookHistory);

                //Refresh Reserved books by Users
            }

            this.PromptMessage("Successfully submitted reservation.");


        }

        protected void linkDate_Click(object sender, EventArgs e)
        {
            calPicker.Visible = true;
            calPicker.SelectedDate = DateTime.Now;
        }

        protected void calPicker_SelectionChanged(object sender, EventArgs e)
        {
            this.linkDate.Text = calPicker.SelectedDate.ToShortDateString();
            calPicker.Visible = false;

            this.CalculateOverdue();
        }

        private void CalculateOverdue()
        {
            taBookHistory.Fill(ds1.BookHistory);
            DataView dvBookHistory = ds1.BookHistory.DefaultView;
            dvBookHistory.RowFilter = "MemberID = " + Convert.ToInt32(this.ddlMember.Text) + " AND DateReturned IS NULL";
            DateTime dtRequested;
            DateTime dtCurrentDate = DateTime.ParseExact(this.linkDate.Text, "yyyy-MM-dd", null);
            int overDueBookCounter = 0;
            foreach (DataRowView dRowView in dvBookHistory)
            {
                dtRequested = DateTime.Parse(dRowView["DateRequested"].ToString());
                if ((dtCurrentDate - dtRequested).TotalDays >= 5)
                {
                    overDueBookCounter += 1;
                }
            }
            this.lblAmountDue.Text = (overDueBookCounter * 5).ToString("C");
        }

        protected void txtReturnBooks_Click(object sender, EventArgs e)
        {
            //Add prompt to proceed

            taBookHistory.Fill(ds1.BookHistory);
            foreach (DataRow dr in ds1.BookHistory.Rows)
            {
                if (Convert.ToInt32(dr["MemberID"]) == Convert.ToInt32(this.ddlMember.Text) && dr["DateReturned"] == null)
                {
                    dr["DateReturned"] = DateTime.Parse(this.linkDate.Text).ToShortDateString();
                }
            }

            taBookHistory.Update(ds1.BookHistory);

            this.PromptMessage("Successfully returned books.");
            
        }

        protected void lbChangePassword_Click(object sender, EventArgs e)
        {
            this.panelNewPwd.Visible = true;
            this.panelNewContact.Visible = false;
        }

        protected void lbChangeContact_Click(object sender, EventArgs e)
        {
            this.panelNewPwd.Visible = false;
            this.panelNewContact.Visible = true;
        }

        protected void btnConfirmChangePwd_Click(object sender, EventArgs e)
        {
            if (this.txtNewPassword.Text.Trim().Equals(this.txtConfirmNewPassword.Text.Trim()))
            {
                taMember.Fill(ds1.Member);

                DataRow[] dr = ds1.Member.Select("MemberID=" + Convert.ToInt32(this.ddlMember.Text));

                dr[0]["Password"] = this.txtNewPassword.Text.Trim();

                taMember.Update(ds1.Member);

                this.PromptMessage("Successfully updated password.");
            }
            else {
                this.PromptMessage("Password did not match.");
            }
        }

        protected void btnUpdateNewEmail_Click(object sender, EventArgs e)
        {
            taMember.Fill(ds1.Member);

            DataRow[] dr = ds1.Member.Select("MemberID=" + Convert.ToInt32(this.ddlMember.Text));

            dr[0]["PhoneNumber"] = this.txtNewPhone.Text.Trim();
            dr[0]["Email"] = this.txtNewEmail.Text.Trim() ;

            taMember.Update(ds1.Member);

            this.PromptMessage("Successfully updated contact.");
        }

        protected void lbDeleteAcctRequest_Click(object sender, EventArgs e)
        {
            taMember.Fill(ds1.Member);
            DataRow[] dRows = ds1.Member.Select("MemberID=" + Convert.ToInt32(this.ddlMember.Text));
            if (dRows.Length > 0)
            {
                dRows[0]["Status"] = false;
                taMember.Update(ds1.Member);

                this.PromptMessage("Successfully submitted to delete account.");
            }

        }

        protected void ddlMember_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.LoadReservedBooks();
            this.CalculateOverdue();
        } 

        protected void btnExtend_Click(object sender, EventArgs e)
        {
            taBook.Fill(ds1.Book);
            taBookHistory.Fill(ds1.BookHistory);
            DataRow[] dRows = ds1.BookHistory.Select("MemberID=" + Convert.ToInt32(this.ddlMember.Text) + " AND DateReturned IS NULL");
            DataRow drTemp;
            bool bInsufficient = false;
            int bookId, memberId;
            string bookName, memberName;
            bool status;
            foreach (DataRow dr in dRows)
            {
                bookId = Convert.ToInt32(dr["BookID"]);
                memberId = Convert.ToInt32(dr["MemberID"]);
                bookName = dr["BookName"].ToString();
                memberName = dr["MemberName"].ToString();
                status = Convert.ToBoolean(dr["Status"]);
                if (this.NumberOfBooksAvailable(bookId, memberId) > 0)
                {
                    dr["DateReturned"] = DateTime.Parse(this.linkDate.Text);

                    //Create new row
                    drTemp = ds1.BookHistory.NewRow();
                    drTemp["BookID"] = bookId;
                    drTemp["BookName"] = bookName;
                    drTemp["MemberID"] = memberId;
                    drTemp["MemberName"] = memberName;
                    drTemp["Status"] = status;
                    drTemp["DateRequested"] = DateTime.Parse(this.linkDate.Text).ToShortDateString();

                    ds1.BookHistory.Rows.Add(drTemp);
                }
                else
                {
                    bInsufficient = true;
                }
                
            }

            if (!bInsufficient)
            {
                taBookHistory.Update(ds1.BookHistory);
                
                this.PromptMessage("Successfully extended books.");
            }
            
        }


        private int NumberOfBooksAvailable(int bookId, int memberId)
        {
            int availableCopies = 0;

            DataRow drBA = ds1.Book.Select("BookID=" + bookId).FirstOrDefault();
            if (drBA != null)
            {
                availableCopies = Convert.ToInt32(drBA["Copies"]) - ds1.BookHistory.Select("BookID=" + bookId + " AND MemberID<>" + memberId + " AND DateReturned IS NULL").Length;
            }

            return availableCopies;
        }


        //protected void Wizard3_ActiveStepChanged(object sender, EventArgs e)
        //{
        //    int step = Wizard3.ActiveStepIndex;

        //    // Disable validation for Step 2. (index is zero-based)
        //    if (step == 1)
        //    {
        //        ToggleValidation(false);
        //    }
        //    else  // Enable validation for subsequent steps.
        //    {
        //        ToggleValidation(true);
        //    }
        //}

        //private void ToggleValidation(bool flag)
        //{
        //    WebControl stepNavTemplate = this.Wizard3.FindControl("StepNavigationTemplateContainerID") as WebControl;
        //    if (stepNavTemplate != null)
        //    {
        //        Button b = stepNavTemplate.FindControl("StepNextButton") as Button;
        //        if (b != null)
        //        {
        //            b.CausesValidation = flag;
        //        }
        //    }
        //}




    }
}
