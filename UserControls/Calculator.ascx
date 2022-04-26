<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Calculator.ascx.cs" Inherits="UserControls.Calculator" %>

<style>
    .calcControl {
    }

    .calcLed {
        text-align: right;
        width:96%;
        font-family:Arial,Tahoma,'Times New Roman';
        font-size:18px;
        box-sizing:border-box;
    }
    button,input[type=submit]{
        width:55px;
        height:55px;
    }
    .calcTable{
       padding:0px;
       border:1px solid black;
       background-color:darkcyan;
    }
    .hidden{
        display:none;
        visibility:hidden;
    }
    .shown{
        display:block;
        visibility:visible;
    }

</style>
<asp:ScriptManager ID="scriptManager" runat="server"></asp:ScriptManager>
<asp:UpdatePanel ID="updatePanel" runat="server">
    <ContentTemplate>
<asp:Panel ID="panelCalc" runat="server" CssClass="calcControl">

 <table class="calcTable">
         <tr>
             <td colspan="4">
                 <asp:TextBox ID="txtCalcled" CssClass="calcLed" runat="server" Text="0"></asp:TextBox> 
             </td>
         </tr>
        <tr>
            <td></td>
            <td></td>
            <td><button class="clearButton">C</button></td>
            <td><button class="backSpaceButton"><[x]</button></td>
        </tr>
<% 
    if (CalcMode == Mode.Standard)
    { 
%>
                <tr>
            <td>
                <asp:Button ID="btnOneDivEx" runat="server" Text="1/x" OnClick="btnOneDivEx_Click" />
            </td>
            <td>
                <button class="pow2XButton">x^2</button>
            </td>
            <td>
                <button class="sqrtXButton">sqrt(x)</button>
            </td>
            <td>
                <button class="actionButton">/</button>
            </td>
        </tr>
<% 
    }
%>

<%  if (CalcMode == Mode.Programmer)
    {
%>
     <tr>
             <td colspan="4">
                 <label>
                     <input type="radio" name="calcMode" id="calcModeHex" value="HEX"/>
                     HEX
                 </label>
                 <label>
                     <input type="radio" name="calcMode" id="calcModeDec" checked="checked" value="DEC"/>
                     DEC
                 </label>
                 <label>
                     <input type="radio" name="calcMode" id="calcModeOct" value="OCT"/>
                     OCT
                 </label>
                 <label>
                     <input type="radio" name="calcMode" id="calcModeBin" value="BIN"/>
                     BIN
                 </label>
                 </td>
         </tr>
      <tr class="hexButtons hidden">
            <td>
                <button class="numberButton">A</button>
            </td>
            <td>
                <button class="numberButton">B</button>
            </td>
            <td>
                <button class="numberButton">C</button>
            </td>
            <td>
                <button class="actionButton">D</button>
            </td>
        </tr>
      <tr class="hexButtons hidden">
            <td>
                <button class="numberButton">E</button>
            </td>
            <td>
                <button class="numberButton">F</button>
            </td>
          </tr>
<%
    }
%>
          <% 
    else if (CalcMode == Mode.Scientific)
    { 
%>
            <tr colspan="3">
            <td>
                <button class="XButton">|x|</button>
            </td>
            <td>
                <button class="expButton">exp</button>
            </td>
            <td>
                <button class="actionButton">%</button>
            </td>
        </tr>
<% 
    }
%>
        <tr>
            <td>
                <button class="numberButton notInBin">7</button>
            </td>
            <td>
                <button class="numberButton notInOct notInBin">8</button>
            </td>
            <td>
                <button class="numberButton notInOct notInBin">9</button>
            </td>
            <td>
                <button class="actionButton">*</button>
            </td>
        </tr>
        <tr>
            <td>
                <button class="numberButton notInBin">4</button>
            </td>
            <td>
                <button class="numberButton notInBin">5</button>
            </td>
            <td>
                <button class="numberButton notInBin">6</button>
            </td>
            <td>
                <button class="actionButton">-</button>
            </td>
        </tr>
        <tr>
            <td>
                <button class="numberButton">1</button>
            </td>
            <td>
                <button class="numberButton notInBin">2</button>
            </td>
            <td>
                <button class="numberButton notInBin">3</button>
            </td>
            <td>
                <button class="actionButton notInBin">+</button>
            </td>
        </tr>
        <tr>
            <td>
                <button class="inverseButton">+/-</button>
            </td>
            <td>
                <button class="numberButton">0</button>
            </td>
            <td>
                <button class="numberButton">.</button>
            </td>
            <td>
          <button class="calculateButton">=</button>
                </td>
        </tr>

    </table>
</asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>



<script>

    const calcLed = document.querySelector(".calcLed");

    const clearButton = document.querySelector(".clearButton");

    const allButtons = document.querySelectorAll("button");

    const numberButtons = document.querySelectorAll(".numberButton");

    const actionButtons = document.querySelectorAll(".actionButton");

    const calculateButton = document.querySelector(".calculateButton");

    const calcModeList = document.querySelectorAll("[name='calcMode']");

    const hexButtonsRows = document.querySelectorAll(".hexButtons");

    const notInOctButtons = document.querySelectorAll(".notInOct");

    const notInBinButtons = document.querySelectorAll(".notInBin");

    const expButton = document.querySelectorAll(".expButton");

    const XButton = document.querySelectorAll(".XButton");

    allButtons.forEach((button) => {

        button.addEventListener("click", (event) => {
            event.preventDefault();
        });

    });

    numberButtons.forEach((button) => {

        button.addEventListener("click", (event) => {

            if (calcLed.value == "0")
                calcLed.value = "";

            calcLed.value += button.textContent;

        });
    });

    actionButtons.forEach((button) => {

        button.addEventListener("click", (event) => {

            const ledLastSymbol = calcLed.value.charAt(calcLed.value.length - 1);

            if (isOpsSymbol(ledLastSymbol)) {
                calcLed.value = calcLed.value.substr(0, calcLed.value.length - 1) + button.textContent;
            }
            else
                calcLed.value += `${button.textContent}`;

        });
    });

    expButton.forEach((button) => {
        button.addEventListener("click", (event) => {
            calcLed.value += Math.exp(calcLed.value);
        });
    });

    expButton.forEach((button) => {
        button.addEventListener("click", (event) => {
            calcLed.value += Math.exp(calcLed.value);
        });
    });

    XButton.forEach((button) => {
        button.addEventListener("click", (event) => {
            calcLed.value += Math.abs(calcLed.value);
        });
    });

    calcModeList.forEach((option) => {
        option.addEventListener("change", () => {
            processCalcModeListChange(event.target.value);
        });
    });

    clearButton.addEventListener("click", (event) => {

        calcLed.value = "0";

    });

    function isOpsSymbol(symbol) {

        const opsSymbols = ['/', '*', '+', '-', '%' ];

        return opsSymbols.indexOf(symbol) > -1;
    }
    calculateButton.addEventListener("click", (event) => {
        try {
            const calcResult = eval(calcLed.value);
            if (isFinite(calcResult)) calcLed.value = calcResult;
        }
        catch (error) {
            console.log(error);
            calcLed.value = "0";
        }
    });

    function processCalcModeListChange(mode) {
        switch (mode) {
            case "HEX": {
                hexButtonsRows.forEach((row) => {
                    row.classList.remove("hidden");
                })
                break;
            }
            case "OCT": {
                disableButtonList(notInOctButtons);
                break;
            }
            case "DEC": {
                enableButtonList(notInOctButtons);
                enableButtonList(notInBinButtons);
                break;
            }
            case "BIN": {
                disableButtonList(notInBinButtons);
                break;
            }
        }
    }

    function disableButtonList(nodeList) {
        notInOctButtons.forEach((button) => {
            button.disabled = true;
        })
    }

    function enableButtonList(nodeList) {
        notInOctButtons.forEach((button) => {
            button.disabled = false;
        })
    }
</script>