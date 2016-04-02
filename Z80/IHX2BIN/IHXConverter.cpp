//---------------------------------------------------------------------------


#pragma hdrstop

#include <iostream.h>
#include <fstream.h>
#include "IHXConverter.h"

//---------------------------------------------------------------------------
CIhxConverter::CIhxConverter() {
	FInputFile = new TStringList();
	FData = (Byte *)GetMemory(65536);
	memset(FData, 65536, 0);
}
//---------------------------------------------------------------------------
CIhxConverter::~CIhxConverter() {
    FreeMemory(FData);
	delete FInputFile;
}
//---------------------------------------------------------------------------
void CIhxConverter::InsertData(const Word _address, const Word _size, const Byte *_data) {
    memcpy(FData + _address, _data, _size);
}
//---------------------------------------------------------------------------
void CIhxConverter::ParseLine(const String _s) {
	Byte data_len;
	Word address;

	String s = _s.LowerCase();

	if (s.Length() > 10 && s.SubString(1, 1) == ':') {
		if (s.SubString(8, 2) == "00") {
			address = 0;
			HexToBin(s.SubString(2, 2).c_str(), &data_len, 1);
			HexToBin(s.SubString(6, 2).c_str(), (char *)&address, 1);
			HexToBin(s.SubString(4, 2).c_str(), ((char *)&address) + 1, 1);
			HexToBin(s.SubString(10, data_len * 2).c_str(), FData + address, data_len);

			cout << IntToStr(data_len) << " bytes at address 0x" << IntToHex(address, 4) << '\n';
        }
	}
}
//---------------------------------------------------------------------------
void CIhxConverter::SaveToFile(const String _FileName, const int _Offset) {
	int data_len = 65535;
	bool found = false;

	while (data_len >= 0 && !found) {
		if (*(FData + data_len) == 0)
			data_len--;
		else
			found = true;
	}

	ofstream output_file;
	output_file.open(_FileName.c_str(), ios::out | ios::binary);
	output_file.write(FData + _Offset, data_len + 2 - _Offset);
	output_file.close();

	cout << '\n' << IntToStr(data_len) << " total bytes written.\n";
}
//---------------------------------------------------------------------------
void CIhxConverter::DoConvert(const String _InputFile, const String _OutputFile, const int _Offset) {
	if (FileExists(_InputFile)) {
		if (FileExists(_OutputFile))
			DeleteFileA(_OutputFile);

        FInputFile->LoadFromFile(_InputFile);
		for (int i = 0; i < FInputFile->Count; i++)
			ParseLine(FInputFile->Strings[i]);

		SaveToFile(_OutputFile, _Offset);

	} else {
        cout << "file " << _InputFile << " not found!";
    }
}
//---------------------------------------------------------------------------
#pragma package(smart_init)
