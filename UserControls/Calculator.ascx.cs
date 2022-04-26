using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UserControls
{
    public partial class Calculator : System.Web.UI.UserControl
    {
        public enum Mode { 
            Standard,
            Programmer,
            Scientific
        }

        public Mode CalcMode { get; set; } = Mode.Standard;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCalculate_Click(object sender, EventArgs e)
        {

        }

        protected void btnOneDivEx_Click(object sender, EventArgs e)
        {
            double currentValue;
            if (Double.TryParse(txtCalcled.Text, out currentValue))
            {
                txtCalcled.Text = (1 / currentValue).ToString();
            }
        }
    }
}