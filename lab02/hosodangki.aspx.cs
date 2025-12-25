using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace clone
{
    public partial class hosodangki : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitDropdowns();
            }
        }

        private void InitDropdowns()
        {
            ddlngay.Items.Clear();
            ddlthang.Items.Clear();
            ddlnam.Items.Clear();

            // Thêm ngày 1-31
            for (int i = 1; i <= 31; i++)
            {
                ddlngay.Items.Add(i.ToString());
            }

            // Thêm tháng 1-12
            for (int i = 1; i <= 12; i++)
            {
                ddlthang.Items.Add(i.ToString());
            }

            // Thêm năm
            int currentYear = DateTime.Now.Year;
            for (int i = currentYear; i >= 1970; i--)
            {
                ddlnam.Items.Add(i.ToString());
            }

            // Chọn mặc định
            ddlngay.SelectedIndex = 0;
            ddlthang.SelectedIndex = 0;
            ddlnam.SelectedIndex = 20; // Năm ~1990
        }

        protected void btndangki_Click(object sender, EventArgs e)
        {
            // Luôn hiển thị thông tin trước
            string username = txttaikhoan.Text;
            string password = txtmk.Text;
            string fullname = txttenkh.Text;
            string birthday = $"{ddlngay.SelectedValue}/{ddlthang.SelectedValue}/{ddlnam.SelectedValue}";
            string email = txtemail.Text;
            string income = txtluong.Text;
            string gender = rdnam.Checked ? "Nam" : "Nữ";
            string address = txtdiachi.Text;
            string phone = txtsdt.Text;

            string html = $"Tên đăng nhập: {username}<br/>";
            html += $"Mật khẩu: {password}<br/>";
            html += $"Họ tên: {fullname}<br/>";
            html += $"Ngày sinh: {birthday}<br/>";
            html += $"Email: {email}<br/>";
            html += $"Thu nhập: {income}<br/>";
            html += $"Giới tính: {gender}<br/>";
            html += $"Địa chỉ: {address}<br/>";
            html += $"Điện thoại: {phone}<br/>";

            ltCustomerInfo.Text = html;

            // Kiểm tra validation
            Validate();

            // Tạo danh sách lỗi
            List<string> errors = new List<string>();

            // Kiểm tra từng validator và thêm lỗi chi tiết
            if (!rfvUsername.IsValid) errors.Add("Tên đăng nhập không được để trống");
            if (!revUsername.IsValid) errors.Add("Tên đăng nhập: Cần có 8-16 ký tự, bao gồm chữ cái, số và ký tự đặc biệt");
            if (!rfvPassword.IsValid) errors.Add("Mật khẩu không được để trống");
            if (!revPassword.IsValid) errors.Add("Mật khẩu: Cần có 8-16 ký tự, bao gồm chữ cái, số và ký tự đặc biệt");
            if (!rfvConfirmPassword.IsValid) errors.Add("Vui lòng nhập lại mật khẩu");
            if (!cvPassword.IsValid) errors.Add("Mật khẩu không khớp");
            if (!rfvFullname.IsValid) errors.Add("Họ tên không được để trống");
            if (!revEmail.IsValid) errors.Add("Email không đúng định dạng");
            if (!rvIncome.IsValid) errors.Add("Thu nhập phải từ 1.000.000 đến 50.000.000 VND");

            // Nếu có lỗi, ghi đè bằng thông báo lỗi
            if (errors.Count > 0)
            {
                string errorHtml = "Lỗi:<br/>";
                foreach (string error in errors)
                {
                    errorHtml += error + "<br/>";
                }
                ltCustomerInfo.Text = errorHtml;
                return;
            }
        }
    }
}
