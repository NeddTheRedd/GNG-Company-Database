<u>**Entity Sets**</u>

**Assumption**:
For Is-a conversion, we are using the E/R style. 

<br>

* *Green_Not_Greed*(<u>**gng ID**</u>, gng name, gng email, gng phone)
* *Global_Affiliate*(<u>**company ID**</u>, company name, company location, company phone, company email)
* *Member*(<u>**member ID**</u>, member name, member phone, member email)
* *Employee*(<u>**employee ID**</u>, employee name, position, salary, date hired)
* *Donor*(<u>**donor ID**</u>, donor name, primary donor contact, amount, donor phone)
* *Office*(<u>**office ID**</u>, office address, office phone, rent)
* *Website*(<u>**URL**</u>, twitter, facebook)
* *Campaign*(<u>**campaign ID**</u>, campaign name, start date, end date, phase, budget)
* *Expenses*(<u>**campaign ID**</u>, material, description, cost, date of purchase)
* *Volunteer*(<u>**volunteer ID**</u>, volunteer name, tier, volunteer phone, volunteer email)
* *Event*(<u>**event ID**</u>, event name, event location, event description, event date)
* *Fundraiser*(<u>**event ID**</u>, target goal, funds raised, sponsorship)


<u>**Relationship Sets**</u>

**Assumption**:
For weak relationships, we are dropping their tables, as they provide no new information. 

<br>

* *Comprises*(<u>**gng ID**</u>, <u>**company ID**</u>, <u>**member ID**</u>)
* *Employs*(<u>**gng ID**</u>, <u>**employee ID**</u>)
* *Supports*(<u>**gng ID**</u>, <u>**donor ID**</u>)
* *Located_At*(<u>**gng ID**</u>, <u>**office ID**</u>)
* *Organizes*(<u>**gng ID**</u>, <u>**campaign ID**</u>)
* *Represents*(<u>**URL**</u>, <u>**campaign ID**</u>)
* *Particpates*(<u>**campaign ID**</u>, <u>**volunteer ID**</u>)
* *Plans*(<u>**campaign ID**</u>, <u>**event ID**</u>)
