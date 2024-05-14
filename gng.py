#!/usr/bin/env python3

import psycopg2
from decimal import Decimal
from psycopg2 import Date


def create_views(cursor):
    """
    Create views in the database by executing SQL queries from a file.

    Parameters:
    - cursor: Cursor object to execute SQL commands.

    Returns:
    None
    """

    with open('/home/leenapthine/coursework/assign3/gng-queries.sql', 'r') as f:
        sql_queries = f.read().split(';')
        for query in sql_queries:
            cursor.execute(query)


def main():
    """
    Main function controlling the flow of the program.

    Returns:
    None
    """

    # Connect to the database
    dbconn = psycopg2.connect(host='studentdb.csc.uvic.ca', user='c370_s100', password='mBYynGhh')
    cursor = dbconn.cursor()

    print("\nHello. How can I help you today?")

    while True:
        print("\nMAIN MENU:")
        print("-" * 120)
        print("1. Make a query")
        print("2. Create and organize campaigns")
        print("3. View accounting information")
        print("4. Browse membership/volunteer history")
        print("5. Annotate member records or campaigns")
        print("6. Sort query by column")
        print("7. Exit\n")
        try:
            directory = int(input("Select a numerical option: "))
            if directory == 1:
                queryOptions(cursor)
            elif directory == 2:
                campaignOps(cursor, dbconn)
            elif directory == 3:
                accounting(cursor, dbconn)
            elif directory == 4:
                memHistory(cursor, dbconn)
            elif directory == 5:
                annotateInfo(cursor, dbconn)
            elif directory == 6:
                sortByColumn(cursor, dbconn)
            elif directory == 7:
                print("\nHave a nice day :)\n")
                break
            else:
                print("Invalid input. Enter an integer between 1 and 5 inclusive.")
        except ValueError:
            print("Invalid input. Enter an integer between 1 and 5 inclusive.")

    cursor.close()
    dbconn.close()


def viewCampaigns(cursor, dbconn):
    """
    Display campaign details.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    cursor.execute("""
    select * from campaign""")

    # Column sizes
    id_width = 12
    campaign_width = 38
    start_width = 13
    end_width = 13
    phase_width = 13
    budget_width = 17
    
    # Headers
    print("{:<12} {:<38} {:<13} {:<13} {:<13} {:<17} {:<}".format("campaign_id", "campaign_name", "start_date", "end_date", "phase", "budget", "campaign_notes"))
    print("-" * 120)

    # Displaying campaign details
    for row in cursor.fetchall():
        print("%-*s %-*s %-*s %-*s %-*s %-*s %s" % (id_width, row[0], campaign_width, row[1], start_width, row[2], end_width, row[3], phase_width, row[4], budget_width, row[5], row[6]))   
    print("\n") 


def viewMembers(cursor,dbconn):  
    """
    Display member details.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    # Display member entity 
    cursor.execute("""
    select * from member
    """)

    # Column sizes
    id_width = 15
    name_width = 20
    phone_width = 20
    email_width = 30

    # Headers
    print("{:<15} {:<20} {:<20} {:<30} {:<}".format("member_id", "member_name", "member_phone", "member_email", "member_notes"))
    print("-" * 120)

    # Displaying member details
    for row in cursor.fetchall():
        print("%-*s %-*s %-*s %-*s %s" % (id_width, row[0], name_width, row[1], phone_width, row[2], email_width, row[3], row[4]))
    print("\n")


def viewVolunteers(cursor, dbconn):
    """
    Display volunteer details.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    # give the current state of the volunteer entity set to the user
    cursor.execute("""
    Select * from volunteer
    """)

    # Column sizes
    id_width = 15
    name_width = 20
    tier_width = 10
    phone_width = 20
    email_width = 30
    
    # Headers
    print("{:<15} {:<20} {:<10} {:<20} {:<30} {:<}".format("volunteer_id", "volunteer_name", "tier", "volunteer_phone", "volunteer_email", "volunteer_notes"))
    print("-" * 120)

    # Displaying volunteer details
    for row in cursor.fetchall():
        print("%-*s %-*s %-*s %-*s %-*s %s" % (id_width, row[0], name_width, row[1], tier_width, row[2], phone_width, row[3], email_width, row[4], row[5]))
    print("\n")


def viewEvents(cursor, dbconn):
    """
    Display event details.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    # give the current state of the event entity set to the user
    cursor.execute("""
    Select * from event
    """)

    # Column sizes
    event_id = 15
    event_name = 40
    location_width = 30
    description_width = 50

    # Headers
    print("{:<15} {:<40} {:<30} {:<50} {:<}".format("event_id", "event_name", "event_location", "event_description", "event_date"))
    print("-" * 120)

    # Displaying event details
    for row in cursor.fetchall():
        print("%-*s %-*s %-*s %-*s %s" % (event_id, row[0], event_name, row[1], location_width, row[2], description_width, row[3], row[4]))
    print("\n")


def viewFundraisers(cursor, dbconn):
    """
    Display the current state of the fundraiser entity set to the user.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    cursor.execute("""
    Select * from fundraiser
    """)

    # Column sizes
    id_width = 15
    target_width = 20
    raised_width = 20

    # Headers
    print("{:<15} {:<20} {:<20} {:<}".format("event_id", "target_goal", "funds_raised", "sponsorships"))
    print("-" * 120)

    for row in cursor.fetchall():
        print("%-*s %-*s %-*s %s" % (id_width, row[0], target_width, row[1], raised_width, row[2], row[3]))
    print("\n")


def viewExpenses(cursor, dbconn):
    """
    Display the current state of the expenses entity set to the user.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    cursor.execute("""
    Select * from expenses
    """)

    # Column sizes
    id_width = 15
    material_width = 25
    description_width = 40
    cost_width = 20

    # Headers
    print("{:<15} {:<25} {:<40} {:<20} {:<}".format("campaign_id", "material", "description", "cost", "date_of_purchase"))
    print("-" * 120)

    for row in cursor.fetchall():
        print("%-*s %-*s %-*s %-*s %s" % (id_width, row[0], material_width, row[1], description_width, row[2], cost_width, row[3], row[4]))
    print("\n")


def sortByColumn(cursor, dbconn):
    """
    Provide options to the user to sort the query results by different columns.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    while True:
        print("\nSORTED QUERY OPTIONS:")
        print("-" * 120)
        print("1. Sort Campaign")
        print("2. Sort Member")
        print("3. Sort Volunteer")
        print("4. Sort Expenses")
        print("5. Return to the main menu\n")
        try:
            s_option = int(input("Enter the sorting option number so that I can direct you: "))
            if s_option == 1:
                sortCampaign(cursor, dbconn)
            elif s_option == 2:
                sortMember(cursor, dbconn)
            elif s_option == 3:
                sortVolunteer(cursor, dbconn)
            elif s_option == 4:
                sortExpenses(cursor, dbconn)
            elif s_option == 5:
                break
            else:
                print("Invalid input. Enter an integer between 1 and 5 inclusive.")
        except ValueError:
            print("Invalid input. Enter an integer between 1 and 5 inclusive.")


def sortExpenses(cursor, dbconn):
    """
    Sort expenses by the specified column.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    while True:
        print("\nQUERY BY EXPENSES COLUMN:")
        print("-" * 120)
        print("\n")
        viewExpenses(cursor, dbconn)

        # For this section, column names (referring to specific SQL data identifiers) cannot be directly passed via 
        # paramaterized queriess. To keep this method secure we are using a loop to validate a very specific set of 
        # valid entries. This will keep the user input safe from hacking. 
        column = input("\nSelect a valid column name: ")
        valid_columns = ["campaign_id", "material", "description", "cost", "date_of_purchase"]
        if column not in valid_columns:
            print("Invalid column name. Please enter a valid column name.")
            continue

        cursor.execute("""
        select * from expenses
        order by {}
        """.format(column))
        print("\nExpenses sorted by {}. Here is the query table table:\n".format(column))
        
        # Column sizes
        id_width = 15
        material_width = 25
        description_width = 40
        cost_width = 20

        # Headers
        print("{:<15} {:<25} {:<40} {:<20} {:<}".format("campaign_id", "material", "description", "cost", "date_of_purchase"))
        print("-" * 120)

        for row in cursor.fetchall():
            print("%-*s %-*s %-*s %-*s %s" % (id_width, row[0], material_width, row[1], description_width, row[2], cost_width, row[3], row[4]))
        print("\n")
        break


def sortCampaign(cursor, dbconn):
    """
    Sort camapaigns by the specified column.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    while True:
        print("\nQUERY BY CAMPAIGN COLUMN:")
        print("-" * 120)
        print("\n")
        viewCampaigns(cursor, dbconn)

        # For this section, column names (referring to specific SQL data identifiers) cannot be directly passed via 
        # paramaterized queriess. To keep this method secure we are using a loop to validate a very specific set of 
        # valid entries. This will keep the user input safe from hacking. 
        column = input("\nSelect a valid column name: ")
        valid_columns = ['campaign_id', 'campaign_name', 'start_date', 'end_date', 'phase', 'budget', 'campaign_notes']
        if column not in valid_columns:
            print("Invalid column name. Please enter a valid column name.")
            continue
        cursor.execute("""
        select * from campaign
        order by {}
        """.format(column))
        print("\nCampaign sorted by {}. Here is the query table table:\n".format(column))
        
        # Column sizes
        id_width = 12
        campaign_width = 38
        start_width = 13
        end_width = 13
        phase_width = 13
        budget_width = 17
    
        # Headers
        print("{:<12} {:<38} {:<13} {:<13} {:<13} {:<17} {:<}".format("campaign_id", "campaign_name", "start_date", "end_date", "phase", "budget", "campaign_notes"))
        print("-" * 120)

        for row in cursor.fetchall():
            print("%-*s %-*s %-*s %-*s %-*s %-*s %s" % (id_width, row[0], campaign_width, row[1], start_width, row[2], end_width, row[3], phase_width, row[4], budget_width, row[5], row[6]))   
        print("\n") 
        break


def sortVolunteer(cursor, dbconn):
    """
    Sort volunteers by the specified column.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    while True:
        print("\nQUERY BY VOLUNTEER COLUMN:")
        print("-" * 120)
        print("\n")
        viewVolunteers(cursor, dbconn)

        # For this section, column names (referring to specific SQL data identifiers) cannot be directly passed via 
        # paramaterized queriess. To keep this method secure we are using a loop to validate a very specific set of 
        # valid entries. This will keep the user input safe from hacking. 
        column = input("\nSelect a valid column name: ")
        valid_columns = ["volunteer_id", "volunteer_name", "tier", "volunteer_phone", "volunteer_email", "volunteer_notes"]
        if column not in valid_columns:
            print("Invalid column name. Please enter a valid column name.")
            continue
        cursor.execute("""
        select * from volunteer
        order by {}
        """.format(column))
        print("\nVolunteers sorted by {}. Here is the query table:\n".format(column))
        
        # Column sizes
        id_width = 15
        name_width = 20
        tier_width = 10
        phone_width = 20
        email_width = 30
    
        # Headers
        print("{:<15} {:<20} {:<10} {:<20} {:<30} {:<}".format("volunteer_id", "volunteer_name", "tier", "volunteer_phone", "volunteer_email", "volunteer_notes"))
        print("-" * 120)

        for row in cursor.fetchall():
            print("%-*s %-*s %-*s %-*s %-*s %s" % (id_width, row[0], name_width, row[1], tier_width, row[2], phone_width, row[3], email_width, row[4], row[5]))
        print("\n")
        break


def sortMember(cursor, dbconn):
    """
    Sort members by the specified column.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """
    
    while True:
        print("\nQUERY BY MEMBER COLUMN:")
        print("-" * 120)
        print("\n")
        viewMembers(cursor, dbconn)

        # For this section, column names (referring to specific SQL data identifiers) cannot be directly passed via 
        # paramaterized queriess. To keep this method secure we are using a loop to validate a very specific set of 
        # valid entries. This will keep the user input safe from hacking. 
        column = input("\nSelect a valid column name: ")
        valid_columns = ["member_id", "member_name", "member_phone", "member_email", "member_notes"]
        if column not in valid_columns:
            print("Invalid column name. Please enter a valid column name.")
            continue
        cursor.execute("""
        select * from member
        order by {}
        """.format(column))
        print("\nMembers sorted by {}. Here is the query table:\n".format(column))
        
        # Column sizes
        id_width = 15
        name_width = 20
        phone_width = 20
        email_width = 30

        # Headers
        print("{:<15} {:<20} {:<20} {:<30} {:<}".format("member_id", "member_name", "member_phone", "member_email", "member_notes"))
        print("-" * 120)

        for row in cursor.fetchall():
            print("%-*s %-*s %-*s %-*s %s" % (id_width, row[0], name_width, row[1], phone_width, row[2], email_width, row[3], row[4]))
        print("\n")
        break


def annotateInfo(cursor, dbconn):
    """
    Annonate to several entity sets.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """
    
    while True:
        print("\nANNOTATION OPTIONS:")
        print("-" * 120)
        print("1. Annotate Campaign")
        print("2. Annotate Member")
        print("3. Annotate Volunteer")
        print("4. Return to the main menu\n")
        try:
            ann_option = int(input("Enter the account option number so that I can direct you: "))
            if ann_option == 1:
                campaignNotes(cursor, dbconn)
            elif ann_option == 2:
                memberNotes(cursor, dbconn)
            elif ann_option == 3:
                volunteerNotes(cursor, dbconn)
            elif ann_option == 4:
                break
            else:
                print("Invalid input. Enter an integer between 1 and 4 inclusive.")
        except ValueError:
            print("Invalid input. Enter an integer between 1 and 4 inclusive.")


def campaignNotes(cursor, dbconn):
    """
    Add campaign notes to the note column.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    while True:
        print("\nCAMPAIGN NOTES:")
        print("-" * 120)
        print("1. View campaign table")
        print("2. Add a note")
        print("3. Return to the annotation menu\n")
        try:
            ann_option = int(input("Enter the notes option so that I can direct you: "))
            if ann_option == 1:
                viewCampaigns(cursor, dbconn)
            elif ann_option == 2:
                while True:
                    campaign_id = int(input("Enter the campaign id that you want to annotate: "))
                    # Validate campaign_id
                    cursor.execute("select count(*) from campaign where campaign_id = %s", [campaign_id])
                    count = cursor.fetchone()[0]
                    if count == 0:
                        print("Invalid campaign ID. Please enter a valid campaign ID.")
                        continue
                    else:
                        break

                note = input("Enter a note: ")
                cursor.execute("""
                update campaign
                set campaign_notes = %s
                where campaign_id = %s 
                """, [note, campaign_id])
            elif ann_option == 3:
                break         
            else:
                print("Invalid input. Enter an integer between 1 and 3 inclusive.")
        except ValueError:
            print("Invalid input. Enter an integer between 1 and 3 inclusive.")


def memberNotes(cursor, dbconn):
    """
    Add member notes to the note column.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    while True:
        print("\nMEMBER NOTES:")
        print("-" * 120)
        print("1. View member table")
        print("2. Add a note")
        print("3. Return to the annotation menu\n")
        try:
            ann_option = int(input("Enter the notes option so that I can direct you: "))
            if ann_option == 1:
                viewMembers(cursor, dbconn)
            elif ann_option == 2:
                while True:
                    member_id = int(input("Enter the member id that you want to annotate: "))
                    # Validate member_id
                    cursor.execute("select count(*) from member where member_id = %s", [member_id])
                    count = cursor.fetchone()[0]
                    if count == 0:
                        print("Invalid member ID. Please enter a valid member ID.")
                        continue
                    else:
                        break

                note = input("Enter a note: ")
                cursor.execute("""
                update member
                set member_notes = %s
                where member_id = %s 
                """, [note, member_id])
            elif ann_option == 3:
                break         
            else:
                print("Invalid input. Enter an integer between 1 and 3 inclusive.")
        except ValueError:
            print("Invalid input. Enter an integer between 1 and 3 inclusive.")


def volunteerNotes(cursor, dbconn):
    """
    Add volunteer notes to the note column.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    while True:
        print("\nVOLUNTEER NOTES:")
        print("-" * 120)
        print("1. View volunteer table")
        print("2. Add a note")
        print("3. Return to the annotation menu\n")
        try:
            ann_option = int(input("Enter the notes option so that I can direct you: "))
            if ann_option == 1:
                viewVolunteers(cursor, dbconn)
            elif ann_option == 2:
                while True:
                    volunteer_id = int(input("Enter the volunteer id that you want to annotate: "))
                    # Validate volunteer_id
                    cursor.execute("select count(*) from volunteer where volunteer_id = %s", [volunteer_id])
                    count = cursor.fetchone()[0]
                    if count == 0:
                        print("Invalid volunteer ID. Please enter a valid volunteer ID.")
                        continue
                    else:
                        break

                note = input("Enter a note: ")
                cursor.execute("""
                update volunteer
                set volunteer_notes = %s
                where volunteer_id = %s 
                """, [note, volunteer_id])
            elif ann_option == 3:
                break         
            else:
                print("Invalid input. Enter an integer between 1 and 3 inclusive.")
        except ValueError:
            print("Invalid input. Enter an integer between 1 and 3 inclusive.")
    

def memHistory(cursor, dbconn):
    """
    Get Member or volunteer history.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    while True:
        print("\nMEMBERSHIP/VOLUNTEER INFO:")
        print("-" * 120)
        print("1. View member history")
        print("2. View volunteer history")
        print("3. Return to the main menu\n")
        try:
            mem_history = int(input("Enter the numerical option number so that I can direct you: "))
            print("\n")
            if mem_history == 1:
                viewMembers(cursor, dbconn)
            elif mem_history == 2:
                viewVolunteers(cursor, dbconn)
            elif mem_history == 3:
                break
            else:
                print("Invalid input. Enter an integer between 1 and 3 inclusive.")
        except ValueError:
            print("Invalid input. Enter an integer between 1 and 3 inclusive.")


def accounting(cursor, dbconn):
    """
    Get accountng data history.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    while True:
        print("\nACCOUNT OPTIONS:")
        print("-" * 120)
        print("1. View all inflow")
        print("2. View all outflow")
        print("3. Return to the main menu\n")
        try:
            a_option = int(input("Enter the account option number so that I can direct you: "))
            if a_option == 1:
                inflow(cursor, dbconn)
            elif a_option == 2:
                outflow(cursor, dbconn)
            elif a_option == 3:
                break
            else:
                print("Invalid input. Enter an integer between 1 and 3 inclusive.")
        except ValueError:
            print("Invalid input. Enter an integer between 1 and 3 inclusive.")


# This section I took inspiration from this source here: https://alexwlchan.net/2018/ascii-bar-charts/
def barChart(count, max_amount):
    """
    Create ASCII bar chart visuals for representing data.

    Parameters:
    - count: The count or value to represent in the bar chart.
    - max_amount: The maximum value to normalize the bar length.

    Returns:
    A string representing the ASCII bar chart.
    """

    # Calculate the number of bars to represent the amount
    bar_chunks, remainder = divmod(int(count * 300 / max_amount), 8)
    bar = '█' * bar_chunks

    # Add fractional part
    if remainder > 0:
        bar += chr(ord('█') + (8 - remainder))

        # If the bar is empty, add a left one-eighth block
        bar = bar or  '▏'
    
    return bar 


def outflow(cursor, dbconn):
    """
    Get accountng outflow data history.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    print("\nEmployee salaries:")
    print("-" * 120)

    cursor.execute("""
    select employee_name, salary
    from employee""")

     # Column sizes
    name_width = 30
    salary_width = 20

    data = cursor.fetchall()

    # Print column headers for the bar chart
    print("{:<30} {:<20} {:<}".format("employee_name", "salary", "bar_chart"))
    print("-" * 120)
    
    max_amount = max(amount for _, amount in data)
    total_salaries = sum(row[1] for row in data)

    for row in data:
        count = row[1]
        bar = barChart(count, max_amount)

        # Print the bar chart along with donor names and amounts
        print("%-*s %-*s %s\n" % (name_width, row[0], salary_width, row[1], bar))
    
    print("\nTOTAL SALARIES: $%.2f\n" % total_salaries)
    print("-" * 120)
    print("\n\nCampaign expenses per campaign:")
    print("-" * 120)

    cursor.execute("""
    select c.campaign_name, COALESCE(SUM(e.cost), 0) AS total_expenses
    from campaign c
    left join expenses e 
    on c.campaign_id = e.campaign_id
    group by c.campaign_name;
    """)

     # Column sizes
    campaign_width = 40
    expenses_width = 30

    data = cursor.fetchall()

    # Print column headers for the bar chart
    print("{:<40} {:<30} {:<}".format("campaign_name", "expenses_width", "bar_chart"))
    print("-" * 120)
    
    max_amount = max(row[1] for row in data)
    total_expenses = sum(row[1] for row in data)

    for row in data:
        count = row[1]
        bar = barChart(count, max_amount)

        # Print the bar chart along with donor names and amounts
        print("%-*s %-*s %s\n" % (campaign_width, row[0], expenses_width, row[1], bar))

    # Print total raised
    print("\nTOTAL CAMPAIGN EXPENSES: $%.2f\n" % total_expenses)
    print("-" * 120)
    print("\n\nOffice rental cost")
    print("-" * 120)

    cursor.execute("""
    select office_address, rent
    from office
    """)

     # Column sizes
    office_width = 50
    rent_width = 15

    data = cursor.fetchall()

    # Print column headers for the bar chart
    print("{:<50} {:<15} {:<}".format("office_address", "rent", "bar_chart"))
    print("-" * 120)
    
    max_amount = max(row[1] for row in data)
    total_office = sum(row[1] for row in data)

    for row in data:
        count = row[1]
        bar = barChart(count, max_amount)

        # Print the bar chart along with donor names and amounts
        print("%-*s %-*s %s\n" % (office_width, row[0], rent_width, row[1], bar))

    # Print total raised
    print("\nTOTAL OFFICE RENT: $%.2f\n" % total_office)
    print("-" * 120)
    print("\n")

    
def inflow(cursor, dbconn):
    """
    Get accountng inflow ndata history.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    print("\nDonor contributions:")
    print("-" * 120)

    cursor.execute("""
    select donor_name, amount
    from donor""")

     # Column sizes
    name_width = 30
    amount_width = 15

    data = cursor.fetchall()

    # Print column headers for the bar chart
    print("{:<30} {:<15} {:<}".format("donar_name", "amount", "bar_chart"))
    print("-" * 120)
    
    max_amount = max(amount for _, amount in data)
    total_donated = sum(row[1] for row in data)

    for row in data:
        count = row[1]
        bar = barChart(count, max_amount)

        # Print the bar chart along with donor names and amounts
        print("%-*s %-*s %s\n" % (name_width, row[0], amount_width, row[1], bar))
    
    print("\nTOTAL DONATED: $%.2f\n" % total_donated)
    print("-" * 120)
    print("\n\nFundraiser contributions:")
    print("-" * 120)

    cursor.execute("""
    select e.event_name, f.funds_raised, c.campaign_name
    from event e
    join fundraiser f 
    on e.event_id = f.event_id
    join plans p 
    on e.event_id = p.event_id
    join campaign c 
    on p.campaign_id = c.campaign_id;
    """)

     # Column sizes
    campaign_width = 40
    event_width = 30
    funds_width = 20

    data = cursor.fetchall()

    # Print column headers for the bar chart
    print("{:<40} {:<30} {:<20} {:<}".format("campaign_name", "event_name", "funds_raised", "bar_chart"))
    print("-" * 120)
    
    max_amount = max(row[1] for row in data)
    total_raised = sum(row[1] for row in data)

    for row in data:
        count = row[1]
        bar = barChart(count, max_amount)

        # Print the bar chart along with donor names and amounts
        print("%-*s %-*s %-*s %s\n" % (campaign_width, row[2], event_width, row[0], funds_width, row[1], bar))

    # Print total raised
    print("\nTOTAL RAISED: $%.2f\n" % total_raised)
    print("-" * 120)
    print("\n")


def campaignOps(cursor, dbconn):
    """
    Main function for adding and altering several entity sets.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    while True:
        print("\nCAMPAIGN OPTIONS:")
        print("-" * 120)
        print("1. Create a new campaign")
        print("2. Add new volunteer")
        print("3. Schedule an event or fundraiser")
        print("4. Return to the main menu\n")
        try:
            c_option = int(input("Enter the campaign option number so that I can direct you: "))
            if c_option == 1:
                newCampaign(cursor, dbconn)
            elif c_option == 2:
                addVolunteer(cursor, dbconn)
            elif c_option == 3:
                scheduleEvent(cursor, dbconn)
            elif c_option == 4:
                print("\n")
                break
            else:
                print("Invalid input. Enter an integer between 1 and 4 inclusive.")
        except ValueError:
            print("Invalid input. Enter an integer between 1 and 4 inclusive.")


def get_date(prompt):
    """
    Prompt user to enter a date.

    Parameters:
    - prompt: A string prompt indicating what the date is for.

    Returns:
    Date object representing the entered date.
    """

    while True:
        try:
            year = int(input("Enter YEAR for {}: ".format(prompt)))
            month = int(input("Enter MONTH (1-12) for {}: ".format(prompt)))
            day = int(input("Enter DAY for {}: ".format(prompt)))
            return Date(year, month, day)
        except ValueError:
            print("Invalid input. Enter a valid date.")


def newCampaign(cursor, dbconn):
    """
    Add a new campaign to the campaign table.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    print("\nENTER CAMPAIGN DATA:")
    print("-" * 120)
    
    try:
        campaign_name = input("What is the campaign name?")  
        start_date = get_date("start date")
        end_date = get_date("end date")
        phase = input("Enter the phase of the campaign (Planning, Monitoring, Execution):")
        budget = float(input("Enter the budget:"))
    except ValueError:
        print("Invalid input. Please enter valid data.")

    cursor.execute("""
    insert into campaign (campaign_name, start_date,
    end_date, phase, budget)
    values (%s, %s, %s, %s, %s)""",
    [campaign_name, start_date, end_date, phase, budget])

    # commit changes
    dbconn.commit()
    print("\nCampaign added successfully.")
    print("Here is the updated campaign table: \n")
    viewCampaigns(cursor, dbconn)


def scheduleEvent(cursor, dbconn):
    """
    Add a new event to the event table.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    print("\nENTER EVENT DATA:")
    print("-" * 120)
    
    try:
        event_name = input("Event name: ")  
        event_location = input("Event location: ")
        event_description = input("Event description: ")
        event_date = get_date("Event date")
        while True:
            campaign_id = input("Enter the campaign ID the event is promoting: ")
            # Validate campaign_id
            cursor.execute("select count(*) from campaign where campaign_id = %s", [campaign_id])
            count = cursor.fetchone()[0]
            if count == 0:
                print("Invalid campaign ID. Please enter a valid campaign ID.")
                continue
            else:
                break
    except ValueError:
        dbconn.rollback()
        print("Invalid input. Please enter valid data.")
    
    cursor.execute("""
    insert into event (event_name, event_location,
    event_description, event_date)
    values (%s, %s, %s, %s)
    returning event_id;""",
    [event_name, event_location, event_description, event_date])
    
    # fetch event ID 
    event_id = cursor.fetchone()[0]

    cursor.execute("""
    insert into plans (campaign_id, event_id)
    values (%s, %s)""",
    [campaign_id, event_id])

    while True:
        try:
            is_fundraiser = input("Is the event a fundraiser? (yes/no): ")
            if is_fundraiser == 'yes':
                newFundraiser(cursor, dbconn, event_id)
                break
            elif is_fundraiser == 'no':
                break
            else:
                print("Invalid input. Enter 'yes' or 'no': ")
        except ValueError:
            dbconn.rollback()
            print("Invalid input. Enter 'yes' or 'no': ")

    # commit changes
    dbconn.commit()

    while True:
        try:
            does_participate = input("Add a volunteer to your event (yes/no): ")
            if does_participate == 'yes':
                while True:
                    volunteer_id = input("Enter the participants volunteer ID: ")
                    # Validate volunteer_id
                    cursor.execute("select count(*) from volunteer where volunteer_id = %s", [volunteer_id])
                    count = cursor.fetchone()[0]
                    if count == 0:
                        print("Invalid volunteer ID. Please enter a valid volunteer ID.")
                        continue
                    else:
                        addParticipates(cursor, dbconn, volunteer_id, event_id)
                        print("\nParticipant added. \n")
                        break
            elif does_participate == 'no':
                break
            else:
                print("Invalid input. Enter 'yes' or 'no': ")
        except ValueError:
            dbconn.rollback()
            print("Invalid input. Enter 'yes' or 'no': ")

    print("\nEvent added successfully.")
    print("Here is the updated event table: \n")
    viewEvents(cursor, dbconn)
    

def newFundraiser(cursor, dbconn, event_id):
    """
    Add a new fundraiser event to the fundraiser table.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.
    - event_id: ID linking fundraiser as an is-a relationship to event

    Returns:
    None
    """

    try:
        print("\nENTER FUNDRAISER DATA:")
        print("-" * 120)

        target_goal = int(input("Enter target $ goal: "))
        funds_raised = int(input("Enter $ currently raised: "))
        sponsorship = input("Enter all sponsors: ")

        cursor.execute("""
        insert into fundraiser (event_id, target_goal,
        funds_raised, sponsorship)
        values (%s, %s, %s, %s)""",
        [event_id, target_goal, funds_raised, sponsorship])

        # commit changes
        dbconn.commit()

    except ValueError:
        dbconn.rollback()
        print("Invalid input. Please enter valid numeric values for target goal and funds raised.")

    except psycopg2.errors.NumericValueOutOfRange as e:
        dbconn.rollback()
        print("Error: $ exceeds the allowed range for the target goal.")
        print("Enter a target goal within allowed range (up to 8 digits).")


    print("\nFundraiser added successfully.")
    print("Here is the updated fundraiser table: \n")
    viewFundraisers(cursor, dbconn)


def addVolunteer(cursor, dbconn):
    """
    Add a new volunteer to the volunteer table.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.

    Returns:
    None
    """

    print("\nENTER VOLUNTEER DATA:")
    print("-" * 120)
    
    try:
        volunteer_name = input("Volunteer name: ")
        tier = input("Tier (one or two): ")
        volunteer_phone = input("Volunteer phone number: ")
        volunteer_email = input("Volunteer e-mail address: ")
        
    except ValueError:
        dbconn.rollback()
        print("Invalid input. Please enter valid values for volunteer information.")

    cursor.execute("""
    insert into volunteer (volunteer_name, tier,
    volunteer_phone, volunteer_email)
    values (%s, %s, %s, %s)
    returning volunteer_id;""",
    [volunteer_name, tier, volunteer_phone, volunteer_email])
    
    # fetch volunteer ID 
    volunteer_id = cursor.fetchone()[0]

    # commit changes
    dbconn.commit()

    while True:
        try:
            does_participate = input("Does the new volunteer particpate in any future event? (yes/no): ")
            if does_participate == 'yes':
                event_id = input("Enter the event ID they participate in: ")
                addParticipates(cursor, dbconn, volunteer_id, event_id)
                break
            elif does_participate == 'no':
                break
            else:
                print("Invalid input. Enter 'yes' or 'no': ")
        except psycopg2.IntegrityError as e:
            dbconn.rollback()
            print("Foreign key violation error:", e)
        except ValueError:
            dbconn.rollback()
            print("Invalid input. Enter 'yes' or 'no': ")

    print("\nVolunteer added successfully.")
    print("Here is the updated volunteer table: \n")

    # give the current state of the campaign entity set to the user
    cursor.execute("""
    Select * from volunteer
    """)
    viewVolunteers(cursor, dbconn)


def addParticipates(cursor, dbconn, volunteer_id, event_id):
    """
    Add a record to the participates table indicating that a volunteer participates in an event.

    Parameters:
    - cursor: Cursor object to execute SQL commands.
    - dbconn: Database connection object.
    - volunteer_id: ID of the volunteer participating in the event.
    - event_id: ID of the event the volunteer is participating in.

    Returns:
    None
    """

    cursor.execute("""
    insert into participates (volunteer_id, event_id)
    values (%s, %s)""",
    [volunteer_id, event_id])

    # commit changes
    dbconn.commit()


def queryOptions(cursor):
    """
    Display query options to the user and execute the selected query.

    Parameters:
    - cursor: Cursor object to execute SQL commands.

    Returns:
    None
    """

    print("\nMay I take your query?\n")
    print("\nQUERY OPTIONS:")
    print("-" * 120)
    print("1. What are the expenses incurred, and the current budget, of each active Green-Not-Greed campaign?")
    print("2. Which Members are also volunteers, and are currently engaged with an event?")
    print("3. Which employees are directly tasked with securing donations from donors, and who are their donor contacts?")
    print("4. Which campaign expenses were incurred after August 8th, 2024, and which campaign they were used for?")
    print("5. What are the names of all employees, and their salaries, who were hired after March 5th, 2023 and who earn more than $25000?")
    print("6. Which materials were used on campaigns with keys less than 3, and have a cost equal to an expense " +
                "incurred between May 10th, 2024 and May 15th, 2024?")
    print("7. Which global affiliates have members that are also volunteers of Green-Not-Greed?")
    print("8. Which campaign events are not fundraiser events?")
    print("9. What is the average cost of each material that has been purchased more than once?")
    print("10. Which campaigns have not pushed their information to a website yet?")
    print("11. Return to main menu\n")

    while True:
        try:
            query = int(input("Enter the number corresponding to your query, or enter '12' to see the query options: "))
            print("\n")
            if query == 1:
                queryOne(cursor)
            elif query == 2:
                queryTwo(cursor)
            elif query == 3:
                queryThree(cursor)
            elif query == 4:
                queryFour(cursor)
            elif query == 5:
                queryFive(cursor)
            elif query == 6:
                querySix(cursor)
            elif query == 7:
                querySeven(cursor)
            elif query == 8:
                queryEight(cursor)
            elif query == 9:
                queryNine(cursor)
            elif query == 10:
                queryTen(cursor)
            elif query == 11:
                break
            elif query == 12:
                print("\nQUERY OPTIONS:")
                print("-" * 120)
                print("1. What are the expenses incurred, and the current budget, of each active Green-Not-Greed campaign?")
                print("2. Which Members are also volunteers, and are currently engaged with an event?")
                print("3. Which employees are directly tasked with securing donations from donors, and who are their donor contacts?")
                print("4. Which campaign expenses were incurred after August 8th, 2024, and which campaign they were used for?")
                print("5. What are the names of all employees, and their salaries, who were hired after March 5th, 2023 and who earn more than $25000?")
                print("6. Which materials were used on campaigns with keys less than 3, and have a cost equal to an expense " +
                            "incurred between May 10th, 2024 and May 15th, 2024?")
                print("7. Which global affiliates have members that are also volunteers of Green-Not-Greed?")
                print("8. Which campaign events are not fundraiser events?")
                print("9. What is the average cost of each material that has been purchased more than once?")
                print("10. Which campaigns have not pushed their information to a website yet?")
                print("11. Return to main menu\n")
            else:
                print("Invalid input. Enter an integer between 1 and 12 inclusive.")
        except ValueError:
            print("Invalid input. Enter an integer between 1 and 12 inclusive.")


def queryOne(cursor):
    """
    Execute and display query one: expenses incurred and current budget of each active Green-Not-Greed campaign.

    Parameters:
    - cursor: Cursor object to execute SQL commands.

    Returns:
    None
    """

    cursor.execute("""
    select * from campaign_expenses_summary
    """)

    # Column sizes
    campaign_width = 40

    # Headers
    print("{:<40} {:<}".format("Campaign Name", "Total Budget"))
    print("-" * 53)

    for row in cursor.fetchall():
        print("%-*s %s" % (campaign_width, row[0], row[1]))
    print("\n")


def queryTwo(cursor):
    """
    Execute and display query two: members who are also volunteers and currently engaged with an event.

    Parameters:
    - cursor: Cursor object to execute SQL commands.

    Returns:
    None
    """

    cursor.execute("""
    select * from member_volunteer_participation
    """)

    # Column sizes
    member_id_width = 10
    volunteer_id_width = 15
    member_name_width = 15

    # Headers
    print("{:<10} {:<15} {:<15} {:<}".format("Member_ID", "Volunteer_ID", "Member", "Event"))
    print("-" * 65)

    for row in cursor.fetchall():
        print("%-*s %-*s %-*s %s" % (member_id_width, row[0], volunteer_id_width, row[1], member_name_width, row[2], row[3]))
    print("\n")


def queryThree(cursor):
    """
    Execute and display query three: employees directly tasked with securing donations from donors and their donor contacts.

    Parameters:
    - cursor: Cursor object to execute SQL commands.

    Returns:
    None
    """

    cursor.execute("""
    select * from employee_donor_relationship
    """)

    # Column sizes
    employee_width = 15
    position_width = 20
    donor_width = 30

    # Headers
    print("{:<15} {:<20} {:<30} {:<}".format("Employee", "Position", "Donor", "Donor Contact"))
    print("-" * 81)

    for row in cursor.fetchall():
        print("%-*s %-*s %-*s %s" % (employee_width, row[0], position_width, row[1], donor_width, row[2], row[3]))
    print("\n")


def queryFour(cursor):
    """
    Execute and display query four: campaign expenses incurred after August 8th, 2024, and the corresponding campaign details.

    Parameters:
    - cursor: Cursor object to execute SQL commands.

    Returns:
    None
    """

    cursor.execute("""
    select * from campaign_expenses_after_aug
    """)

    # Column sizes
    campaign_width = 40
    material_width = 20
    description_width = 30
    cost_width = 10

    # Headers
    print("{:<40} {:<20} {:<30} {:<10} {:<}".format("Campaign Name", "Material", "Description", "Cost", "Date of Purchase"))
    print("-" * 120)

    for row in cursor.fetchall():
        print("%-*s %-*s %-*s %-*s %s" % (campaign_width, row[0], material_width, row[1], description_width, row[2], cost_width, row[3], row[4]))
    print("\n")


def queryFive(cursor):
    """
    Execute and display query five: names and salaries of employees hired after March 5th, 2023, earning more than $25000.

    Parameters:
    - cursor: Cursor object to execute SQL commands.

    Returns:
    None
    """

    cursor.execute("""
    select * from employee_salaries_date_hired
    """)

    # Column sizes
    salary_width = 15

    # Headers
    print("{:<15} {:<}".format("Salary", "Employee"))
    print("-" * 30)

    for row in cursor.fetchall():
        print("%-*s %s" % (salary_width, row[0], row[1]))
    print("\n")


def querySix(cursor):
    """
    Execute and display query six: materials used on campaigns with keys less than 3 and costs equal to expenses incurred between May 10th, 2024 and May 15th, 2024.

    Parameters:
    - cursor: Cursor object to execute SQL commands.

    Returns:
    None
    """

    cursor.execute("""
    select * from complicated_expense_query
    """)

    # Headers
    print("{:<}".format("Material"))
    print("-" * 8)

    for row in cursor.fetchall():
        print("%s" % (row[0]))
    print("\n")


def querySeven(cursor):
    """
    Execute and display query seven: global affiliates with members who are also volunteers of Green-Not-Greed.

    Parameters:
    - cursor: Cursor object to execute SQL commands.

    Returns:
    None
    """

    cursor.execute("""
    select * from affiliate_volunteer_relationship
    """)

    # Column sizes
    company_width = 25

    # Headers
    print("{:<25} {:<}".format("Company", "Member"))
    print("-" * 40)

    for row in cursor.fetchall():
        print("%-*s %s" % (company_width, row[0], row[1]))
    print("\n")


def queryEight(cursor):
    """
    Execute and display query eight: campaign events that are not fundraiser events.

    Parameters:
    - cursor: Cursor object to execute SQL commands.

    Returns:
    None
    """

    cursor.execute("""
    select * from not_fundraiser
    """)

    # Headers
    print("{:<}".format("Event"))
    print("-" * 25)

    for row in cursor.fetchall():
        print("%s" % (row[0]))
    print("\n")


def queryNine(cursor):
    """
    Execute and display query nine: average cost of each material that has been purchased more than once.

    Parameters:
    - cursor: Cursor object to execute SQL commands.

    Returns:
    None
    """

    cursor.execute("""
    select * from avg_cost
    """)

    # Column sizes
    material_width = 15

    # Headers
    print("{:<15} {:<}".format("Material", "Average Cost"))
    print("-" * 36)

    for row in cursor.fetchall():
        print("%-*s %s" % (material_width, row[0], row[1]))
    print("\n")


def queryTen(cursor):
    """
    Execute and display query ten: campaigns that have not pushed their information to a website yet.

    Parameters:
    - cursor: Cursor object to execute SQL commands.

    Returns:
    None
    """

    cursor.execute("""
    select * from not_pushed
    """)

    # Headers
    print("{:<}".format("Campaign Name"))
    print("-" * 20)

    for row in cursor.fetchall():
        print("%s" % (row[0]))
    print("\n")


if __name__ == "__main__": main()
