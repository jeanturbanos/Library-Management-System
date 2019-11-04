using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace LibraryManagementSystem
{
    public partial class Administrator : System.Web.UI.Page
    {
        //create object of DataSet1.xsd
        private DataSet1 ds1 = new DataSet1();

        //create the object of the table Adapters
        DataSet1TableAdapters.BookTableAdapter taBook;
        DataSet1TableAdapters.BookHistoryTableAdapter taBookHistory;
        DataSet1TableAdapters.MemberTableAdapter taMember;

        private static int updateID = 0;


        protected void Page_Load(object sender, EventArgs e)
        {

            this.btnSave.Text = "Add";
            taBook = new DataSet1TableAdapters.BookTableAdapter();
            taBookHistory = new DataSet1TableAdapters.BookHistoryTableAdapter();
            taMember = new DataSet1TableAdapters.MemberTableAdapter();

            if (Page.IsPostBack == false)
            {
                
                this.PopulateMemberRequest();
            }
        }
        
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            //CommandName is property to find which  Commmand Field has been clicked by user
            if (e.CommandName == "Select")
            {
                // Select the row which is clicked by the user
                GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];

                txtTitleBook.Text = row.Cells[3].Text;
                txtAuthor.Text = row.Cells[4].Text;
                txtPublisher.Text = row.Cells[5].Text;
                txtBkCategory.Text = row.Cells[6].Text;
                txtCopies.Text = row.Cells[7].Text;
                updateID = Convert.ToInt16(row.Cells[2].Text);
                this.btnSave.Text = "Update";
            }

            if (e.CommandName == "Delete")
            {
                taBookHistory.Fill(ds1.BookHistory);
                GridViewRow row = GridView1.Rows[Convert.ToInt32(e.CommandArgument)];
                DataRow[] dRows =  ds1.BookHistory.Select("MemberID=" + row.Cells[2].Text + " AND DateReturned NOT IS NULL");
                if (dRows.Length < 0)
                {
                    taBook.Fill(ds1.Book);

                    DataRow[] dr = ds1.Book.Select("BookID=" + row.Cells[2].Text);
                    dr[0].Delete();

                    taBook.Update(ds1.Book);
                    GridView1.DataBind();
                }
                else
                {
                    this.PromptMessage("Cannot delete member profile with books issued or unpaid overdues.");
                }
                
                
            }

        }


        private void PromptMessage(string message)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + message + "')", true);
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (updateID == 0)
            {
                taBook.Fill(ds1.Book);
                DataView dvBook = ds1.Book.DefaultView;
                dvBook.RowFilter = "Book = '" + txtTitleBook.Text + "' ";
                if (dvBook.Count == 0)
                {
                    DataSet1.BookRow row = ds1.Book.NewBookRow();

                    row.Book = txtTitleBook.Text;
                    row.Author = txtAuthor.Text;
                    row.Publisher = txtPublisher.Text;
                    row.Category = txtBkCategory.Text;
                    row.Copies = Convert.ToInt32(txtCopies.Text);

                    ds1.Book.Rows.Add(row);
                    taBook.Update(ds1.Book);
                    GridView1.DataBind();

                    txtTitleBook.Text = " ";
                    txtAuthor.Text = " ";
                    txtPublisher.Text = " ";
                    txtBkCategory.Text = " ";
                    txtCopies.Text = " ";


                    lblMessage.Text = "Book added successfully";
                }
                else
                {
                    lblMessage.Text = "Book already exists";
                    txtTitleBook.Focus();
                }
            }
            else if (updateID > 0)
            {
                taBook.Fill(ds1.Book);

                DataRow[] dr = ds1.Book.Select("BookID=" + updateID);

                dr[0]["Book"] = txtTitleBook.Text;
                dr[0]["Author"] = txtAuthor.Text;
                dr[0]["Publisher"] = txtPublisher.Text;
                dr[0]["Category"] = txtBkCategory.Text;
                dr[0]["Copies"] = Convert.ToInt32(txtCopies.Text);
                
                taBook.Update(ds1.Book);
                GridView1.DataBind();
                
                txtTitleBook.Text = " ";
                txtAuthor.Text = " ";
                txtPublisher.Text = " ";
                txtBkCategory.Text = " ";
                txtCopies.Text = " ";
            }
        }

        protected void btnClear_Click1(object sender, EventArgs e)
        {
            updateID = 0;
            txtTitleBook.Text = " ";
            txtAuthor.Text = " ";
            txtPublisher.Text = " ";
            txtBkCategory.Text = " ";
            txtCopies.Text = " ";
            txtTitleBook.Focus();
            btnSave.Text = "Add";
        }

        private void PopulateMemberRequest()
        {

            taMember.Fill(ds1.Member);
            
            DataTable dt = new DataTable();

            CommandField selectCommandField = new CommandField();
            selectCommandField.ShowSelectButton = true;
            selectCommandField.SelectText = "Confirm Delete";
            gvMemberRequest.Columns.Add(selectCommandField);

            dt.Columns.Add(new DataColumn("Member ID", typeof(string)));
            dt.Columns.Add(new DataColumn("Name", typeof(string)));
            dt.Columns.Add(new DataColumn("Phone", typeof(string)));
            dt.Columns.Add(new DataColumn("Email", typeof(string)));

            DataRow drTemp;
            foreach (DataRow dr in ds1.Member.Rows)
            {
                if (!Convert.ToBoolean(dr["Status"].ToString()))
                {
                    drTemp = dt.NewRow();
                    drTemp[0] = dr["MemberID"].ToString();
                    drTemp[1] = dr["Name"].ToString();
                    drTemp[2] = dr["PhoneNumber"].ToString();
                    drTemp[3] = dr["Email"].ToString();

                    dt.Rows.Add(drTemp);
                }
            }
            gvMemberRequest.DataSource = dt;
            gvMemberRequest.DataBind();


        }

        protected void gvMemberRequest_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                taBookHistory.Fill(ds1.BookHistory);
                GridViewRow row = gvMemberRequest.Rows[Convert.ToInt32(e.CommandArgument)];

                DataRow[] dRows = ds1.BookHistory.Select("MemberID=" + Convert.ToInt32(row.Cells[1].Text) + " AND DateReturned NOT IS NULL ");
                if (dRows.Length <= 0)
                {
                    taMember.Fill(ds1.Member);

                    DataRow[] dr = ds1.Member.Select("MemberID=" + Convert.ToInt32(row.Cells[1].Text));
                    dr[0].Delete();

                    taMember.Update(ds1.Member);

                    gvMemberRequest.DataBind();
                }
                else
                {
                    this.PromptMessage("Cannot delete member with unsettled transactions.");
                }


            }
        }
    }
}