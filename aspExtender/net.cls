VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "net"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Public Function outerInclude(strURLToGet As String) As String
    Dim iRetVal As Integer
    Dim bRetVal As Integer
    Dim sBuffer As Variant
    Dim sReadBuffer As String * 32767
    Dim bDoLoop As Boolean
    Dim sStatus As String
    Dim lBytesRead As Long
    Dim lBytesTotal As Long
    Dim lBufferLength As Long
    Dim sBuffer2 As Long
    Dim lpdwError As Long
    Dim lpszBuffer As String
    Dim lpdwBufferLength As Long
    sBuffer = ""
    sBuffer2 = 0
    lBufferLength = 4
    hInternetSession = InternetOpen(scUserAgent, INTERNET_OPEN_TYPE_PRECONFIG, vbNullString, vbNullString, 0)


    If hInternetSession > 0 Then
        iRetVal = InternetQueryOption(hInternetSession, INTERNET_OPTION_CONNECT_TIMEOUT, sBuffer2, lBufferLength)
        iRetVal = InternetSetOption(hInternetSession, INTERNET_OPTION_CONNECT_TIMEOUT, 2000, 4)
        iRetVal = InternetQueryOption(hInternetSession, INTERNET_OPTION_CONNECT_TIMEOUT, sBuffer2, lBufferLength)
        
        iRetVal = InternetSetOption(hInternetSession, INTERNET_OPTION_RECEIVE_TIMEOUT, 4000, 4)
        
        iRetVal = InternetQueryOption(hInternetSession, INTERNET_OPTION_RECEIVE_TIMEOUT, sBuffer2, lBufferLength)
        
        iRetVal = InternetSetOption(hInternetSession, INTERNET_OPTION_SEND_TIMEOUT, 4000, 4)
        iRetVal = InternetQueryOption(hInternetSession, INTERNET_OPTION_SEND_TIMEOUT, sBuffer2, lBufferLength)
        
        iRetVal = InternetSetOption(hInternetSession, INTERNET_OPTION_CONNECT_RETRIES, 1, 4)
        iRetVal = InternetQueryOption(hInternetSession, INTERNET_OPTION_CONNECT_RETRIES, sBuffer2, lBufferLength)
        
        iRetVal = InternetSetOption(hInternetSession, INTERNET_OPTION_DATA_SEND_TIMEOUT, 4000, 4)
        iRetVal = InternetQueryOption(hInternetSession, INTERNET_OPTION_DATA_SEND_TIMEOUT, sBuffer2, lBufferLength)
        
        iRetVal = InternetSetOption(hInternetSession, INTERNET_OPTION_DATA_RECEIVE_TIMEOUT, 4000, 4)
        iRetVal = InternetQueryOption(hInternetSession, INTERNET_OPTION_DATA_RECEIVE_TIMEOUT, sBuffer2, lBufferLength)
        hUrlFile = InternetOpenUrl(hInternetSession, strURLToGet, vbNullString, 0, INTERNET_FLAG_RELOAD, 0)


        If hUrlFile > 0 Then
            iRetVal = InternetSetOption(hUrlFile, INTERNET_OPTION_CONNECT_TIMEOUT, 2000, 4)
            bDoLoop = True


            While bDoLoop
                
                sReadBuffer = Space(32767)
                lBytesRead = 0
                
                bDoLoop = InternetReadFile(hUrlFile, sReadBuffer, Len(sReadBuffer), lBytesRead)
                lBytesTotal = lBytesTotal + lBytesRead
                
                sBuffer = sBuffer & Left$(sReadBuffer, lBytesRead)
                
                If Not CBool(lBytesRead) Then bDoLoop = False
            Wend
        End If
    End If
    InternetCloseHandle (hUrlFile)
    InternetCloseHandle (hInternetSession)
    hInternetSession = 0
    hUrlFile = 0
    outerInclude = sBuffer
End Function


