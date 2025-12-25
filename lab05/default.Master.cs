using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace lab05
{
    public partial class _default : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateCartCount();

            }
        }

        public void UpdateCartCount()
        {
            if (Session["CartCount"] != null)
            {
                spCartCount.InnerText = Session["CartCount"].ToString();
            }
            else
            {
                spCartCount.InnerText = "0";
            }
        }
    }
}