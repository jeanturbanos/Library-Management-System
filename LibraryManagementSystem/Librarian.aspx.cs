using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace LibraryManagementSystem
{
    public partial class Librarian : System.Web.UI.Page
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
                //DropDownList1.DataSource = MultiView1.Views;
                //DropDownList1.DataTextField = "ID";
                //DropDownList1.DataBind();
                this.PopulateBook();
                this.DisplayCurrentDate();
                this.LoadBookHistory(1);
                //this.PopulateMember();

                //this.LoadReservedBooks();
                //this.CalculateOverdue();
            }
        }

        private void PopulateBook()
        {
            this.LoadBooks();

            bookListingGv.DataSource = dt;
            bookListingGv.DataBind();

        }

        private void DisplayCurrentDate()
        {
            linkDate.Text = DateTime.Now.ToShortDateString();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            
            this.LoadBooks();

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
                default:
                    dv.RowFilter = "";
                    break;
            }
            
            bookListingGv.DataSource = dv;
            bookListingGv.DataBind();
        }
        
        private void LoadBooks()
        {

            taBook.Fill(ds1.Book);
            taBookHistory.Fill(ds1.BookHistory);

            dt = new DataTable();

            dt.Columns.Add(new DataColumn("Book Id", typeof(string)));
            dt.Columns.Add(new DataColumn("Book", typeof(string)));
            dt.Columns.Add(new DataColumn("Author", typeof(string)));
            dt.Columns.Add(new DataColumn("Publisher", typeof(string)));
            dt.Columns.Add(new DataColumn("Category", typeof(string)));
            dt.Columns.Add(new DataColumn("Available", typeof(Int32)));

            DataRow drTemp;
            foreach (DataRow dr in ds1.Book.Rows)
            {
                drTemp = dt.NewRow();
                drTemp[0] = dr["BookID"].ToString();
                drTemp[1] = dr["Book"].ToString();
                drTemp[2] = dr["Author"].ToString();
                drTemp[3] = dr["Publisher"].ToString();
                drTemp[4] = dr["Category"].ToString();
                drTemp[5] = Convert.ToInt32(dr["Copies"].ToString()) - this.GetTotalReservedBooks(Convert.ToInt32(dr["BookID"].ToString()));
                dt.Rows.Add(drTemp);
            }
        }

        private void LoadBookHistory(int type)
        {
            taBookHistory.Fill(ds1.BookHistory);

            dt = new DataTable();
            //default is 1
            dt.Columns.Add(new DataColumn("Book Id", typeof(string)));
            dt.Columns.Add(new DataColumn("BookName", typeof(string)));
            dt.Columns.Add(new DataColumn("Member Id", typeof(string)));
            dt.Columns.Add(new DataColumn("MemberName", typeof(string)));
            dt.Columns.Add(new DataColumn("Date Issued", typeof(string)));
            if (type == 2) //Overdue
            {
                dt.Columns.Add(new DataColumn("Days Overdue", typeof(Int32)));
            }

            DataRow drTemp;
            foreach (DataRow dr in ds1.BookHistory.Rows)
            {
                if ((DateTime.Parse(this.linkDate.Text) - DateTime.Parse(dr["DateRequested"].ToString()).AddDays(5)).TotalDays > 0)
                {
                    drTemp = dt.NewRow();
                    drTemp[0] = dr["BookID"].ToString();
                    drTemp[1] = dr["BookName"].ToString();
                    drTemp[2] = dr["MemberId"].ToString();
                    drTemp[3] = dr["MemberName"].ToString();
                    drTemp[4] = dr["DateRequested"].ToString();
                    if (type == 2)
                    {
                        drTemp[5] = (DateTime.Parse(this.linkDate.Text) - DateTime.Parse(dr["DateRequested"].ToString()).AddDays(5)).TotalDays; // Create a function to get overdue days
                    }
                    dt.Rows.Add(drTemp);
                }
            }

        }

        private void PromptMessage(string message)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('" + message + "')", true);
        }


        private Int32 GetTotalReservedBooks(int bookId)
        {
            return ds1.BookHistory.Select("BookID=" + bookId + " AND DateReturned IS NULL").Length;
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
        }
        
        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            if (ddlReportOptions.Text.Equals("Issued"))
            {
                this.LoadBookHistory(1);
            }
            else if (ddlReportOptions.Text.Equals("Overdue"))
            {
                this.LoadBookHistory(2);
            }

            reportListingGv.DataSource = dt;
            reportListingGv.DataBind();
        }
    }
}