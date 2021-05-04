Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.IO

Public Class _Default
    Inherits System.Web.UI.Page
    Dim adp As SqlDataAdapter
    Dim cmd As SqlCommand
    Dim con As New SqlConnection
    Dim connection As String
    Dim globalLoanReference As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Page.MaintainScrollPositionOnPostBack = True
        Page.ClientScript.RegisterOnSubmitStatement([GetType], "val", "fnOnUpdateValidators();")
        con = New SqlConnection(ConfigurationManager.ConnectionStrings("Constring").ConnectionString)
        If Not IsPostBack Then
            globalLoanReference = "Loan" + DateTime.Now.ToString("ddMMyyyyHHmmss")
        End If
    End Sub
    Public Sub msgbox(ByVal strMessage As String)

        'finishes server processing, returns to client.
        Dim strScript As String = "<script language=JavaScript>"
        strScript += "window.alert(""" & strMessage & """);"
        strScript += "</script>"
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = strScript
        Page.Controls.Add(lbl)
    End Sub
    Protected Sub btnImport_Click(sender As Object, e As EventArgs) Handles btnImport.Click


        If Path.GetFileName(FileUpload1.PostedFile.FileName) = "" Then
            msgbox("Please select a file")
            Exit Sub
        End If

        'the code
        Dim Key As String = ""
        Dim excelPath As String = Server.MapPath("~/Documents/") + Path.GetFileName(FileUpload1.PostedFile.FileName)
        FileUpload1.SaveAs(excelPath)
        Dim fileName As String = Path.GetFileName(FileUpload1.PostedFile.FileName)
        Dim connString As String = String.Empty
        Dim extension As String = Path.GetExtension(FileUpload1.PostedFile.FileName)
        Select Case extension
            Case ".xls"
                'Excel 97-03
                connString = ConfigurationManager.ConnectionStrings("Excel03ConString").ConnectionString
                Exit Select
            Case ".xlsx"
                'Excel 07 or higher
                connString = ConfigurationManager.ConnectionStrings("Excel07+ConString").ConnectionString
                Exit Select
            Case ".XLSX"
                'Excel 07 or higher
                connString = ConfigurationManager.ConnectionStrings("Excel07+ConString").ConnectionString
                Exit Select

        End Select
        connString = String.Format(connString, excelPath)
        Using excel_con As New OleDbConnection(connString)
            excel_con.Open()

            Dim dt As New DataTable()
            dt = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, Nothing)

            Dim excelSheets As String() = New String(dt.Rows.Count - 1) {}
            Dim i As Integer = 0
            For Each row As DataRow In dt.Rows

                excelSheets(i) = row("TABLE_NAME").ToString()

                If row("TABLE_NAME").ToString().ToLower().Replace("$", "") = "financials" Then

                    Dim sheet As String = excel_con.GetSchema("Tables").Rows(i)("TABLE_NAME")
                    Dim dtExcelData As New DataTable()
                    Using oda As New OleDbDataAdapter((Convert.ToString("SELECT * FROM [" & sheet & "]")), excel_con)
                        oda.Fill(dtExcelData)
                    End Using
                    Dim Count As Integer = 0 '          
                    For Each rows As DataRow In dtExcelData.Rows
                        Count += 1
                        If (Count >= 4) Then
                            'msgbox(rows.Item(0).ToString().Replace("'", "''"))
                            If String.IsNullOrEmpty(rows.Item(0).ToString()) = False Then
                                SaveFinancials(globalLoanReference, rows.Item(0).ToString().Replace("'", "''"), "Financials", rows.Item(1).ToString().Replace("$", ""), rows.Item(2).ToString().Replace("$", ""), rows.Item(3).ToString().Replace("$", ""), rows.Item(4).ToString().Replace("$", ""), rows.Item(5).ToString().Replace("$", ""), "0", fileName, "Microfinance")

                            End If
                        End If

                    Next
                End If
                i = i + 1
            Next



            msgbox("File uploaded successfully")
            loadFR()
            Exit Sub

        End Using

    End Sub
    Protected Sub Button10_Click(sender As Object, e As EventArgs)
        Try
            UpdateFinancials()
            msgbox("Financials Updated")
        Catch ex As Exception
            msgbox("Financials not updated")
        End Try

    End Sub
    Public Sub SaveFinancials(ByVal AppNo As String, ByVal Criteria As String, ByVal TypeSheet As String, ByVal ActualYear1 As String, ByVal ActualYear2 As String, ByVal ActualYear3 As String, ByVal ProjectedYear1 As String, ByVal ProjectedYear2 As String, ByVal ProjectedYear3 As String, ByVal FileName As String, ByVal Model As String)
        'inset query
        Dim insert As String = "insert into FinanceRatios([LoanReference],[Criteria],[TypeSheet],[ActualYear1],[ActualYear2],[ActualYear3],[ProjectedYear1],[ProjectedYear2],[ProjectedYear3],[FileName],[Model],[LoanID]) values ('" & globalLoanReference & "','" & Criteria & "','" & TypeSheet & "','" & chkr(ActualYear1) & "','" & chkr(ActualYear2) & "','" & chkr(ActualYear3) & "','" & ProjectedYear1 & "','" & ProjectedYear2 & "','" & ProjectedYear3 & "','" & FileName & "','" & Model & "','" & globalLoanReference & "')"
        If con.State = ConnectionState.Open Then
            con.Close()
        End If
        con.Open()
        Using cmd = New SqlCommand(insert, con)
            cmd.ExecuteNonQuery()
        End Using
    End Sub
    Private Function chkr(ByVal two As String) As Double
        Try
            If IsNumeric(two) = False Then
                two = "0.00"
            End If


            Return Math.Round(Convert.ToDouble(two), 4)
        Catch ex As Exception
            Return 0
        End Try
    End Function
    Protected Sub Button5_Click(sender As Object, e As EventArgs) Handles Button5.Click
        If globalLoanReference = "" Then
            msgbox("Loan Reference is required")
            Exit Sub
        End If
        Try
            If con.State = ConnectionState.Open Then
                con.Close()
            End If
            con.Open()
            cmd = New SqlCommand("delete from FinanceRatios where LoanReference='" & globalLoanReference & "'", con)
            cmd.ExecuteNonQuery()
            'delete stuff
            msgbox("Successfully Cleared")
            loadFR()
        Catch ex As Exception
            msgbox("Could not clear")

        End Try
    End Sub
    Public Sub loadFR()
        If con.State = ConnectionState.Open Then
            con.Close()
        End If
        con.Open()
        Dim s1 As String = "select * from FinanceRatios where LoanReference='" & globalLoanReference & "'"

        cmd = New SqlCommand(s1, con)
        Dim ds As New DataSet
        adp = New SqlDataAdapter(cmd)
        adp.Fill(ds, "QD")

        sr1.Text = ""
        sr2.Text = ""
        sr3.Text = ""
        sr4.Text = ""
        sr5.Text = ""


        top1.Text = ""
        top2.Text = ""
        top3.Text = ""
        top4.Text = ""
        top5.Text = ""

        nbc1.Text = ""
        nbc2.Text = ""
        nbc3.Text = ""
        nbc4.Text = ""
        nbc5.Text = ""

        th1.Text = ""
        th2.Text = ""
        th3.Text = ""
        th4.Text = ""
        th5.Text = ""

        tn1.Text = ""
        tn2.Text = ""
        tn3.Text = ""
        tn4.Text = ""
        tn5.Text = ""
        te1.Text = ""
        te2.Text = ""
        te3.Text = ""
        te4.Text = ""
        te5.Text = ""

        dsp1.Text = ""
        dsp2.Text = ""
        dsp3.Text = ""
        dsp4.Text = ""
        dsp5.Text = ""

        dbr1.Text = ""
        dbr2.Text = ""
        dbr3.Text = ""
        dbr4.Text = ""
        dbr5.Text = ""

        tn1.Text = ""
        tn2.Text = ""
        tn3.Text = ""
        tn4.Text = ""
        tn5.Text = ""

        ndsp1.Text = ""
        ndsp2.Text = ""
        ndsp3.Text = ""
        ndsp4.Text = ""
        ndsp5.Text = ""


        For Each dr As DataRow In ds.Tables(0).Rows

            If dr("Criteria").ToString().ToLower().Replace(" ", "") = "salesrevenue" Then

                sr1.Text = dr("ActualYear1").ToString()
                sr2.Text = dr("ActualYear2").ToString()
                sr3.Text = dr("ActualYear3").ToString()
                sr4.Text = dr("ProjectedYear1").ToString()
                sr5.Text = dr("ProjectedYear2").ToString()

            End If
            If dr("Criteria").ToString().ToLower().Replace(" ", "") = "salescost" Then

                sc1.Text = dr("ActualYear1").ToString()
                sc2.Text = dr("ActualYear2").ToString()
                sc3.Text = dr("ActualYear3").ToString()
                sc4.Text = dr("ProjectedYear1").ToString()
                sc5.Text = dr("ProjectedYear2").ToString()

            End If
            If dr("Criteria").ToString().ToLower().Replace(" ", "") = "totaloperatingexpenses" Then

                top1.Text = dr("ActualYear1").ToString()
                top2.Text = dr("ActualYear2").ToString()
                top3.Text = dr("ActualYear3").ToString()
                top4.Text = dr("ProjectedYear1").ToString()
                top5.Text = dr("ProjectedYear2").ToString()

            End If
            If dr("Criteria").ToString().ToLower().Replace(" ", "") = "netbusinesscashflow" Then
                nbc1.Text = dr("ActualYear1").ToString()
                nbc2.Text = dr("ActualYear2").ToString()
                nbc3.Text = dr("ActualYear3").ToString()
                nbc4.Text = dr("ProjectedYear1").ToString()
                nbc5.Text = dr("ProjectedYear2").ToString()
            End If
            If dr("Criteria").ToString().ToLower().Replace(" ", "") = "totalhouseholdexpenses" Then
                th1.Text = dr("ActualYear1").ToString()
                th2.Text = dr("ActualYear2").ToString()
                th3.Text = dr("ActualYear3").ToString()
                th4.Text = dr("ProjectedYear1").ToString()
                th5.Text = dr("ProjectedYear2").ToString()
            End If
            If dr("Criteria").ToString().ToLower().Replace(" ", "") = "totalincome" Then
                tn1.Text = dr("ActualYear1").ToString()
                tn2.Text = dr("ActualYear2").ToString()
                tn3.Text = dr("ActualYear3").ToString()
                tn4.Text = dr("ProjectedYear1").ToString()
                tn5.Text = dr("ProjectedYear2").ToString()

                Try
                    Dim myA As Decimal = Convert.ToDecimal(tn2.Text)


                Catch ex As Exception

                End Try
            End If
            'Balance Sheet
            If dr("Criteria").ToString().ToLower().Replace(" ", "") = "totalexpenses" Then

                te1.Text = dr("ActualYear1").ToString()
                te2.Text = dr("ActualYear2").ToString()
                te3.Text = dr("ActualYear3").ToString()
                te4.Text = dr("ProjectedYear1").ToString()
                te5.Text = dr("ProjectedYear2").ToString()
            End If
            If dr("Criteria").ToString().ToLower().Replace(" ", "") = "disposableincome" Then
                dsp1.Text = dr("ActualYear1").ToString()
                dsp2.Text = dr("ActualYear2").ToString()
                dsp3.Text = dr("ActualYear3").ToString()
                dsp4.Text = dr("ProjectedYear1").ToString()
                dsp5.Text = dr("ProjectedYear2").ToString()
            End If
            If dr("Criteria").ToString().ToLower().Replace(" ", "") = "dbr@50%" Then
                dbr1.Text = dr("ActualYear1").ToString()
                dbr2.Text = dr("ActualYear2").ToString()
                dbr3.Text = dr("ActualYear3").ToString()
                dbr4.Text = dr("ProjectedYear1").ToString()
                dbr5.Text = dr("ProjectedYear2").ToString()
            End If
            If dr("Criteria").ToString().ToLower().Replace(" ", "") = "cedaloaninstallment" Then
                cl1.Text = dr("ActualYear1").ToString()
                cl2.Text = dr("ActualYear2").ToString()
                cl3.Text = dr("ActualYear3").ToString()
                cl4.Text = dr("ProjectedYear1").ToString()
                cl5.Text = dr("ProjectedYear2").ToString()
            End If
            If dr("Criteria").ToString().ToLower().Replace(" ", "") = "netdisposbaleincome" Then
                ndsp1.Text = dr("ActualYear1").ToString()
                ndsp2.Text = dr("ActualYear2").ToString()
                ndsp3.Text = dr("ActualYear3").ToString()
                ndsp4.Text = dr("ProjectedYear1").ToString()
                ndsp5.Text = dr("ProjectedYear2").ToString()
            End If

        Next
    End Sub

    Public Sub UpdateFinancials()

        SaveFinancialsU("salesrevenue", sr1.Text, sr2.Text, sr3.Text, sr4.Text, sr5.Text, "0", "Financials")
        SaveFinancialsU("salescost", sc1.Text, sc2.Text, sc3.Text, sc4.Text, sc5.Text, "0", "Financials")
        SaveFinancialsU("totaloperatingexpenses", top1.Text, top2.Text, top3.Text, top4.Text, top5.Text, "0", "Financials")
        SaveFinancialsU("netbusinesscashflow", nbc1.Text, nbc2.Text, nbc3.Text, nbc4.Text, nbc5.Text, "0", "Financials")
        SaveFinancialsU("totalhouseholdexpenses", th1.Text, th2.Text, th3.Text, th4.Text, th5.Text, "0", "Financials")
        SaveFinancialsU("totalincome", tn1.Text, tn2.Text, tn3.Text, tn4.Text, tn5.Text, "0", "Financials")
        SaveFinancialsU("totalexpenses", te1.Text, te2.Text, te3.Text, te4.Text, te5.Text, "0", "Financials")
        SaveFinancialsU("disposableincome", dsp1.Text, dsp2.Text, dsp3.Text, dsp4.Text, dsp5.Text, "0", "Financials")
        SaveFinancialsU("dbr@50%", dbr1.Text, dbr2.Text, dbr3.Text, dbr4.Text, dbr5.Text, "0", "Financials")
        SaveFinancialsU("cedaloaninstallment", cl1.Text, cl2.Text, cl3.Text, cl4.Text, cl5.Text, "0", "Financials")
        SaveFinancialsU("netdisposableincome", ndsp1.Text, ndsp2.Text, ndsp3.Text, ndsp4.Text, ndsp5.Text, "0", "Financials")
        loadFR()
    End Sub
    Public Sub SaveFinancialsU(ByVal Criteria As String, ByVal ActualYear1 As String, ByVal ActualYear2 As String, ByVal ActualYear3 As String, ByVal ProjectedYear1 As String, ByVal ProjectedYear2 As String, ByVal ProjectedYear3 As String, ByVal TypeSheet As String)
        'inset query
        Dim insert As String = "Update  FinanceRatios set [ActualYear1]='" & chkr(ActualYear1) & "',[ActualYear2]='" & chkr(ActualYear2) & "',[ActualYear3]='" & chkr(ActualYear3) & "',[ProjectedYear1]='" & chkr(ProjectedYear1) & "',[ProjectedYear2]='" & chkr(ProjectedYear2) & "',[ProjectedYear3]='" & chkr(ProjectedYear3) & "' where LoanReference='" & globalLoanReference & "'  and Replace(Lower([Criteria]),' ','')='" & Criteria & "'"
        If con.State = ConnectionState.Open Then
            con.Close()
        End If
        con.Open()
        Using cmd = New SqlCommand(insert, con)
            cmd.ExecuteNonQuery()
        End Using


    End Sub
    Public Function chkFNN(Criteria As String) As Integer

        cmd = New SqlCommand("Select * from FinanceRatios  where LoanReference='" & globalLoanReference & "'  and Replace(Lower([Criteria]),' ','')='" & Criteria & "' ", con)
        Dim ds As New DataSet
        adp = New SqlDataAdapter(cmd)
        adp.Fill(ds, "QD")
        If ds.Tables(0).Rows.Count > 0 Then
            Return 1
        Else
            Return 0
        End If
    End Function

    Protected Sub btn_Submit_Click(sender As Object, e As EventArgs) Handles btn_Submit.Click
        'insert and save application

        If first_name.Text = "" Then
            msgbox("First name is required")
            Return
        End If
        If last_name.Text = "" Then
            msgbox("Last name is required")
            Return
        End If
        If email_address.Text = "" Then
            msgbox("Email address is required")
            Return
        End If
        If mobile_number.Text = "" Then
            msgbox("Mobile number is required")
            Return
        End If
        If loan_amount.Text = "" Then
            msgbox("Loan amount is required")
            Return
        End If
        If repayment_period.Text = "" Then
            msgbox("Repayment period is required")
            Return
        End If
        If id_number.Text = "" Then
            msgbox("ID number is required")
            Return
        End If

        'save the loan application
        Dim insert As String = "INSERT INTO [dbo].[Loan]
           ([FirstName]
           ,[LastName]
           ,[Email]
           ,[Mobile]
           ,[LoanAmount]
           ,[RepaymentPeriod]
           ,[IDNumber]
           ,[PassportNumber]
           ,[Reference])
     VALUES
           ('" & first_name.Text & "'
           ,'" & last_name.Text & "'
           ,'" & email_address.Text & "'
           ,'" & mobile_number.Text & "'
           ,'" & loan_amount.Text & "'
           ,'" & repayment_period.Text & "'
           ,'" & id_number.Text.Trim().Replace(" ", "") & "'
           ,'" & passport_number.Text & "'
           ,'" & globalLoanReference & "')"


        If con.State = ConnectionState.Open Then
                con.Close()
            End If
            con.Open()
            Using cmd = New SqlCommand(insert, con)
                cmd.ExecuteNonQuery()
            End Using

            msgbox("Loan Successfully Submitted")

            first_name.Text = ""
            last_name.Text = ""
            email_address.Text=""
            mobile_number.Text = ""
            loan_amount.Text &=""
            repayment_period.Text = ""
            id_number.Text=""
            passport_number.Text = ""


            sr1.Text = ""
            sr2.Text = ""
            sr3.Text = ""
            sr4.Text = ""
            sr5.Text = ""


            top1.Text = ""
            top2.Text = ""
            top3.Text = ""
            top4.Text = ""
            top5.Text = ""

            nbc1.Text = ""
            nbc2.Text = ""
            nbc3.Text = ""
            nbc4.Text = ""
            nbc5.Text = ""

            th1.Text = ""
            th2.Text = ""
            th3.Text = ""
            th4.Text = ""
            th5.Text = ""

            tn1.Text = ""
            tn2.Text = ""
            tn3.Text = ""
            tn4.Text = ""
            tn5.Text = ""
            te1.Text = ""
            te2.Text = ""
            te3.Text = ""
            te4.Text = ""
            te5.Text = ""

            dsp1.Text = ""
            dsp2.Text = ""
            dsp3.Text = ""
            dsp4.Text = ""
            dsp5.Text = ""

            dbr1.Text = ""
            dbr2.Text = ""
            dbr3.Text = ""
            dbr4.Text = ""
            dbr5.Text = ""

            tn1.Text = ""
            tn2.Text = ""
            tn3.Text = ""
            tn4.Text = ""
            tn5.Text = ""

            ndsp1.Text = ""
            ndsp2.Text = ""
            ndsp3.Text = ""
            ndsp4.Text = ""
            ndsp5.Text = ""



    End Sub
End Class