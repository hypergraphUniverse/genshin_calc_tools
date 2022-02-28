/**
 * @file floatTypeValidataion.cpp
 * @author hypergraph
 * @brief A small tool to validate the data for conversion between Float32 and Float64
 * @version 0.1
 * @date 2022-02-27
 * 
 * @copyright Copyright (c) 2022
 * 
 */
#include<iostream>
#include<iomanip>
#include<limits>
#include<string>
using namespace std;

/**
 * @brief Convert double d bitwise into a string 
 * 
 * @param d the double that is to be converted
 * @param s a string to save the result
 */
void double_to_bin(double d, string &s);

/**
 * @brief display the double and in it's bitwise form with Sign/Exponent/Mantisse
 * 
 * @param d the double that is to be displayed
 */
void display_double(double d);

// Those data are form Dimbreath/GenshinData/ExcelBinOutput/ReliquaryAffixExcelConfigData.json 
int main(void){
    float x=23.9;     //23.899999618530273
	display_double(x);
    x=3.97;    //3.9700000286102295
    display_double(x);
    x=0.042;    //0.041999999433755875
    display_double(x);
}

/* result: Genshin is using Float32 as Original datatype and was displayed above in Float64
 * If double is used, then those 9/0s in Mantissa would be longer
 * Could reference to the julia code in the same folder for better understanding of this.
*/


void double_to_bin(double d, string &s)
{
	for(int i = 63; i >= 0; i--)
	{
		s.push_back('0'+ ( (*(unsigned long long *)(&d) >> i) & 1) ) ; 
	}
}

void display_double(double d){
	string s;
	double_to_bin(d,s);

    cout<<"double:\t"<<setprecision(std::numeric_limits<double>::digits10+2)<<d<<endl;

	cout<<"Sign:\t\t"<<s.substr(0,1)<<endl;
	cout<<"Exp:\t\t"<<s.substr(1,11)<<endl;
    cout<<"Mantisse:\t"<<s.substr(12,52)<<endl<<endl;
}