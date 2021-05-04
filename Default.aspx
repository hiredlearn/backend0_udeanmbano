<%@ Page Title="Home Page" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.vb" Inherits="VBApplicationForm._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style type="text/css">
        .tooltip-inner {
            max-width: 350px;
            /* If max-width does not work, try using width instead */
            width: 350px;
            text-align: right;
        }

        .tooltip {
            max-width: 350px;
            /* If max-width does not work, try using width instead */
            width: 350px;
            text-align: right;
        }
    </style>
    <script type = "text/javascript">
        function DisableButtons() {
            var inputs = document.getElementsByTagName("INPUT");
            for (var i in inputs) {
                if (inputs[i].type == "button" || inputs[i].type == "submit") {
                    inputs[i].disabled = true;
                }
            }
        }
        window.onbeforeunload = DisableButtons;
    </script>


    <div class="jumbotron">
        <h1>Loan Application</h1>
     </div>

    <div class="row">
        <div class="col-md-12">

            <div class="form-horizontal">
  <!-- 2 column grid layout with text inputs for the first and last names -->
  <div class="row">
       <div class="row label-info">
                                        <div class="col-xs-12 control-label"  >
                                            <div style="text-align:left">
                                                <h3>
                               <asp:Label ID="Label270"  runat="server" CssClass="control-label"  Text="Static Details"></asp:Label>
                                   </h3>
                                            </div>
                                                  
                                        </div>
                                    </div>
    <div class="col-md-6">
      <div class="form-outline">
       <label class="form-label" for="form6Example1">First name</label>
          <asp:TextBox id="first_name" CssClass="form-control" runat="server"/>
        
      </div>
    </div>
    <div class="col-md-6">
      <div class="form-outline">
          <label class="form-label" for="form6Example2">Last name</label>
      <asp:TextBox id="last_name" CssClass="form-control" runat="server" />
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-md-6">
      <div class="form-outline">
       <label class="form-label" for="form6Example1">Email</label>
          <asp:TextBox  id="email_address" CssClass="form-control" runat="server" TextMode="Email" />
        
      </div>
    </div>
    <div class="col-md-6">
      <div class="form-outline">
          <label class="form-label" for="form6Example2">Mobile</label>
      <asp:TextBox id="mobile_number" CssClass="form-control" runat="server" TextMode="Phone" />
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-md-6">
      <div class="form-outline">
       <label class="form-label" for="form6Example1">Loan  Amount</label>
          <asp:TextBox id="loan_amount" CssClass="form-control" runat="server" TextMode="Number" />
        
      </div>
    </div>
    <div class="col-md-6">
      <div class="form-outline">
          <label class="form-label" for="form6Example2">Repayment Period</label>
      <asp:TextBox id="repayment_period"  CssClass="form-control" runat="server" TextMode="Number" />
      </div>
    </div>
  </div>
                  <div class="row">
    <div class="col-md-6">
      <div class="form-outline">
       <label class="form-label" for="form6Example1">ID Number</label>
          <asp:TextBox id="id_number"  CssClass="form-control" runat="server" />
        
      </div>
    </div>
    <div class="col-md-6">
      <div class="form-outline">
          <label class="form-label" for="form6Example2">Passport Number</label>
      <asp:TextBox id="passport_number"  CssClass="form-control" runat="server" />
      </div>
    </div>
  </div>
                
                                                                          <div class="row">
                                                                         
             
                                      <div class="row label-info">
                                        <div class="col-xs-12 control-label"  >
                                            <div style="text-align:left">
                                                <h3>
                               <asp:Label ID="Label1"  runat="server" CssClass="control-label"  Text="Finance Performance"></asp:Label>
                                   </h3>
                                            </div>
                                                  
                                        </div>
                                    </div>
                                                                              </div>
                                     
                                                                          <div class="row">
                                                                              <div class="hidden">
                                           <asp:RadioButtonList RepeatDirection="Horizontal" ID="DropDownList2" runat="server">
                                           	<asp:listitem Text="Commercial" Value="Commercial"></asp:listitem>
	                                        <asp:listitem Text="Livestock" Value="Livestock"></asp:listitem>
	                                        <asp:listitem Text="Property" Value="Property"></asp:listitem>
                                           </asp:RadioButtonList> </div>

                                                <div style="width:100px">
                                                     <asp:FileUpload ID="FileUpload1"  runat="server" >
                                           
                                                     </asp:FileUpload>
       
                                        </div>
                                                                               
                                     
                                            
                                        <div class="col-xs-2">
                                         <asp:Button ID="btnImport"  runat="server" Text="Import" OnClick="btnImport_Click" />
      
                                             </div>
                                                                 <div class="col-xs-4">
                                         <asp:Button ID="Button5" runat="server" Text="Clear Exsisting Ratios" OnClick="Button5_Click" />
      
                                             </div>
                                           </div>
                                    <div class="row label-info">
                                        <div class="col-xs-12 control-label">
                                           Profit/Loss Account
                                        </div>
                                    </div>
                                    <div class="row label-info">
                                       
                                          <div class="col-xs-6 control-label">
                                            <asp:Label ID="Label146" runat="server" Text="Existing Business"></asp:Label>
                                        </div>
                                          <div class="col-xs-6 control-label">
                                            <asp:Label ID="Label147" runat="server" Text="Start Up Business"></asp:Label>
                                        </div>
                                        
                                         </div>
                                    <div class="row label-info">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label111" runat="server" Text=""></asp:Label>
                                        </div>
                                          <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label113" runat="server" Text=" Actual"></asp:Label>
                                        </div>
                                          <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label137" runat="server" Text="Actual"></asp:Label>
                                        </div>
                                          <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label138" runat="server" Text="Forecast"></asp:Label>
                                        </div>
                                          <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label140" runat="server" Text="Forecast"></asp:Label>
                                        </div>
                                          <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label144" runat="server" Text="Forecast"></asp:Label>
                                        </div>
                                         </div>
                                     <div class="row label-info">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label29" runat="server" Text=""></asp:Label>
                                        </div>
                                          <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label30" runat="server" Text=" Monthly"></asp:Label>
                                        </div>
                                          <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label31" runat="server" Text="Annually"></asp:Label>
                                        </div>
                                          <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label32" runat="server" Text="Weekly"></asp:Label>
                                        </div>
                                          <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label105" runat="server" Text="Monthly"></asp:Label>
                                        </div>
                                          <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label107" runat="server" Text="Annually"></asp:Label>
                                        </div>
                                         </div>
                                            <div class="row">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label27" runat="server" Text="Sales Revenue"></asp:Label>
                                        </div>
                                        <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="sr1" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="sr2" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="sr3" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="sr4" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="sr5" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                               
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label98" runat="server" Text="Sales Cost"></asp:Label>
                                        </div>
                                        <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="sc1" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="sc2" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="sc3" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="sc4" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="sc5" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                               
                                    </div>
                                     <div class="row">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label33" runat="server" Text="Total Operating Expenses"></asp:Label>
                                        </div>
                                        <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="top1" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="top2" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="top3" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                               <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="top4" runat="server">                      
                                            </asp:TextBox>
                                     </div> 
                                          <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="top5" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                    </div>
                                     <div class="row">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label34" runat="server" Text="Net Business Cashflow"></asp:Label>
                                        </div>
                                        <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="nbc1" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="nbc2" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="nbc3" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="nbc4" runat="server">                      
                                            </asp:TextBox></div>

                                                          <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="nbc5" runat="server">                      
                                            </asp:TextBox>
                                     
                                     </div>   
                                    </div>
                                     <div class="row">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label35" runat="server" Text="Total Household expenses"></asp:Label>
                                        </div>
                                        <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="th1" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="th2" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="th3" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                               <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="th4" runat="server">                      
                                            </asp:TextBox>
                                     </div>  
                                             <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="th5" runat="server">                      
                                            </asp:TextBox>
                                     </div>  
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label46" runat="server" Text="Total Income"></asp:Label>
                                        </div>
                                        <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="tn1" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="tn2" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="tn3" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                        <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="tn4" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                               <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="tn5" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                    </div>
                                 
                                    <div class="row">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label53" runat="server" Text="Total Expenses"></asp:Label>
                                        </div>
                                        <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="te1" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="te2" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="te3" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                             <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="te4" runat="server">                      
                                            </asp:TextBox></div> 

                                                   <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="te5" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                        
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label89" runat="server" Text="Disposable Income"></asp:Label>
                                        </div>
                                        <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="dsp1" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="dsp2" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="dsp3" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                               <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="dsp4" runat="server">                      
                                            </asp:TextBox>
                                     </div>  
                                          <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="dsp5" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label93" runat="server" Text="DBR @50%"></asp:Label>
                                        </div>
                                        <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="dbr1" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="dbr2" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="dbr3" runat="server">                      
                                            </asp:TextBox>

                                     </div>
                                              <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="dbr4" runat="server">                      
                                            </asp:TextBox>
                                     </div>   
                                          <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="dbr5" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label96" runat="server" Text="CEDA Loan Installment"></asp:Label>
                                        </div>
                                        <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="cl1" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="cl2" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="cl3" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="cl4" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                          <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="cl5" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label97" runat="server" Text="Net Disposable Income"></asp:Label>
                                        </div>
                                        <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="ndsp1" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="ndsp2" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                 <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="ndsp3" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                            <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="ndsp4" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                                   <div class="col-xs-2">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm text-uppercase"  ID="ndsp5" runat="server">                      
                                            </asp:TextBox>
                                     </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-2 control-label">
                                            <asp:Label ID="Label153" runat="server" Text="Comment"></asp:Label>
                                        </div>
                                        <div class="col-xs-6">
                                         <asp:TextBox  CssClass="col-xs-12 form-control input-sm tinymce"  ID="txtFinPerfomanceTextArea" TextMode="multiline" Columns="50" Rows="5" runat="server">
                                            
                                            </asp:TextBox>
                                     
                                     </div>
                                    </div>
                                                      <div class="row">
                                        <div class="col-xs-2 control-label">
                                         <asp:Button ID="Button10" CssClass="btn btn-primary" runat="server" Text="Update Financials" OnClick="Button10_Click"></asp:Button>
                                       
                                        </div>   </div>

                <br /><br />
                  <div class="col-md-12">
                      <asp:Button ID="btn_Submit" CssClass="btn btn-primary btn-block mb-4" runat="server" Text="Submit Application" ></asp:Button>
                                       
                   </div>
</div>
            </div>
    </div>

</asp:Content>
