//---------------------------------------------------------------------------

#include <vcl.h>

//---------------------------------------------------------------------------

#ifndef IHXConverterH
#define IHXConverterH
//---------------------------------------------------------------------------
class CIhxConverter {
private:
	TStringList *FInputFile;
	Byte *FData;

	void CIhxConverter::InsertData(const Word _address, const Word _size, const Byte *_data);
	void CIhxConverter::ParseLine(const String _s);
	void CIhxConverter::SaveToFile(const String _FileName, const int _Offset);

public:
	CIhxConverter();
	~CIhxConverter();

	void DoConvert(const String _InputFile, const String _OutputFile, const int _Offset);
};
//---------------------------------------------------------------------------
#endif
