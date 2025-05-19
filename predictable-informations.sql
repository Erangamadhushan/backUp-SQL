-- database_setup.sql


-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS company_management;

-- Select the database to use
USE company_management;

-- Create Departments table
CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    budget DECIMAL(15, 2),
    manager_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Employees table
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT,
    manager_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

-- Add foreign key constraint to departments table for manager_id
ALTER TABLE departments
ADD CONSTRAINT fk_department_manager
FOREIGN KEY (manager_id) REFERENCES employees(employee_id) ON DELETE SET NULL;

-- Create Projects table
CREATE TABLE IF NOT EXISTS projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(15, 2),
    department_id INT,
    project_manager_id INT,
    status ENUM('Not Started', 'In Progress', 'Completed', 'On Hold') DEFAULT 'Not Started',
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL,
    FOREIGN KEY (project_manager_id) REFERENCES employees(employee_id) ON DELETE SET NULL
);

-- Create Employee_Project junction table (for many-to-many relationship)
CREATE TABLE IF NOT EXISTS employee_projects (
    employee_id INT,
    project_id INT,
    role VARCHAR(50),
    hours_allocated INT,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE
);

-- Insert data into departments
INSERT INTO departments (department_name, location, budget) VALUES
('Human Resources', 'Building A, Floor 2', 500000.00),
('Engineering', 'Building B, Floor 1', 2000000.00),
('Marketing', 'Building A, Floor 3', 1500000.00),
('Finance', 'Building C, Floor 2', 800000.00),
('Sales', 'Building C, Floor 1', 1200000.00);

-- Insert data into employees
-- Note: We're inserting managers first, then other employees
INSERT INTO employees (first_name, last_name, email, phone, hire_date, salary, department_id, manager_id) VALUES
-- Department managers (no manager_id yet)
('John', 'Smith', 'john.smith@company.com', '555-1001', '2010-06-15', 95000.00, 1, NULL),
('Emily', 'Johnson', 'emily.johnson@company.com', '555-1002', '2012-03-22', 120000.00, 2, NULL),
('Michael', 'Brown', 'michael.brown@company.com', '555-1003', '2011-09-30', 110000.00, 3, NULL),
('Sarah', 'Williams', 'sarah.williams@company.com', '555-1004', '2013-11-15', 105000.00, 4, NULL),
('David', 'Jones', 'david.jones@company.com', '555-1005', '2010-05-10', 115000.00, 5, NULL),

-- Regular employees
('Robert', 'Davis', 'robert.davis@company.com', '555-1006', '2015-07-18', 75000.00, 1, 1),
('Jennifer', 'Miller', 'jennifer.miller@company.com', '555-1007', '2016-01-22', 72000.00, 1, 1),
('Christopher', 'Wilson', 'christopher.wilson@company.com', '555-1008', '2018-06-05', 65000.00, 1, 1),

('Jessica', 'Moore', 'jessica.moore@company.com', '555-1009', '2017-03-12', 90000.00, 2, 2),
('Matthew', 'Taylor', 'matthew.taylor@company.com', '555-1010', '2019-05-07', 85000.00, 2, 2),
('Amanda', 'Anderson', 'amanda.anderson@company.com', '555-1011', '2020-01-15', 82000.00, 2, 2),
('Daniel', 'Thomas', 'daniel.thomas@company.com', '555-1012', '2018-11-30', 88000.00, 2, 2),

('Laura', 'Jackson', 'laura.jackson@company.com', '555-1013', '2016-08-24', 78000.00, 3, 3),
('James', 'White', 'james.white@company.com', '555-1014', '2017-10-09', 81000.00, 3, 3),
('Elizabeth', 'Harris', 'elizabeth.harris@company.com', '555-1015', '2019-02-18', 76000.00, 3, 3),

('Ryan', 'Martin', 'ryan.martin@company.com', '555-1016', '2015-09-15', 83000.00, 4, 4),
('Nicole', 'Thompson', 'nicole.thompson@company.com', '555-1017', '2017-04-22', 79000.00, 4, 4),
('Steven', 'Garcia', 'steven.garcia@company.com', '555-1018', '2018-08-14', 77000.00, 4, 4),

('Michelle', 'Martinez', 'michelle.martinez@company.com', '555-1019', '2016-07-11', 80000.00, 5, 5),
('Andrew', 'Robinson', 'andrew.robinson@company.com', '555-1020', '2017-12-03', 82000.00, 5, 5);

-- Update department managers
UPDATE departments SET manager_id = 1 WHERE department_id = 1;
UPDATE departments SET manager_id = 2 WHERE department_id = 2;
UPDATE departments SET manager_id = 3 WHERE department_id = 3;
UPDATE departments SET manager_id = 4 WHERE department_id = 4;
UPDATE departments SET manager_id = 5 WHERE department_id = 5;

-- Insert data into projects
INSERT INTO projects (project_name, start_date, end_date, budget, department_id, project_manager_id, status) VALUES
('HR System Upgrade', '2023-01-15', '2023-06-30', 150000.00, 1, 1, 'In Progress'),
('Employee Wellness Program', '2023-03-01', '2023-12-31', 75000.00, 1, 6, 'In Progress'),

('New Product Development', '2023-02-10', '2024-01-15', 500000.00, 2, 2, 'In Progress'),
('Software Architecture Redesign', '2023-05-01', '2023-11-30', 300000.00, 2, 9, 'Not Started'),
('Mobile App Enhancement', '2023-01-05', '2023-07-30', 250000.00, 2, 10, 'In Progress'),

('Q3 Marketing Campaign', '2023-07-01', '2023-09-30', 400000.00, 3, 3, 'Not Started'),
('Brand Refresh Initiative', '2023-04-15', '2023-10-15', 350000.00, 3, 13, 'In Progress'),

('Annual Financial Audit', '2023-05-01', '2023-06-30', 100000.00, 4, 4, 'In Progress'),
('Cost Optimization Project', '2023-08-01', '2023-12-15', 150000.00, 4, 16, 'Not Started'),

('Q3 Sales Strategy', '2023-07-01', '2023-09-30', 50000.00, 5, 5, 'Not Started'),
('International Market Expansion', '2023-03-15', '2024-03-15', 750000.00, 5, 19, 'In Progress');

-- Insert data into employee_projects junction table
INSERT INTO employee_projects (employee_id, project_id, role, hours_allocated) VALUES
(1, 1, 'Project Manager', 80),
(6, 1, 'Business Analyst', 120),
(7, 1, 'HR Specialist', 160),

(1, 2, 'Executive Sponsor', 20),
(6, 2, 'Project Manager', 100),
(8, 2, 'Wellness Coordinator', 160),

(2, 3, 'Project Manager', 100),
(9, 3, 'Lead Engineer', 160),
(10, 3, 'Developer', 160),
(11, 3, 'QA Engineer', 120),
(12, 3, 'DevOps Engineer', 80),

(2, 4, 'Executive Sponsor', 40),
(9, 4, 'Project Manager', 120),
(11, 4, 'Software Architect', 160),
(12, 4, 'Lead Developer', 160),

(10, 5, 'Project Manager', 120),
(11, 5, 'Developer', 160),
(12, 5, 'UX Designer', 100),

(3, 6, 'Project Manager', 100),
(14, 6, 'Marketing Specialist', 160),
(15, 6, 'Content Creator', 120),

(3, 7, 'Executive Sponsor', 40),
(13, 7, 'Project Manager', 120),
(14, 7, 'Design Lead', 160),
(15, 7, 'Brand Strategist', 140),

(4, 8, 'Project Manager', 80),
(16, 8, 'Financial Analyst', 160),
(17, 8, 'Audit Specialist', 160),
(18, 8, 'Compliance Officer', 100),

(4, 9, 'Executive Sponsor', 20),
(16, 9, 'Project Manager', 100),
(17, 9, 'Financial Analyst', 120),
(18, 9, 'Data Analyst', 140),

(5, 10, 'Project Manager', 80),
(19, 10, 'Sales Strategist', 120),
(20, 10, 'Market Analyst', 100),

(5, 11, 'Executive Sponsor', 40),
(19, 11, 'Project Manager', 120),
(20, 11, 'International Sales Lead', 160);

-- Create a view to show employee details with department
CREATE OR REPLACE VIEW employee_details AS
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    e.email,
    e.phone,
    e.hire_date,
    e.salary,
    d.department_name,
    CONCAT(m.first_name, ' ', m.last_name) AS manager_name
FROM 
    employees e
JOIN 
    departments d ON e.department_id = d.department_id
LEFT JOIN 
    employees m ON e.manager_id = m.employee_id;

-- Create a view to show project details
CREATE OR REPLACE VIEW project_details AS
SELECT 
    p.project_id,
    p.project_name,
    p.start_date,
    p.end_date,
    p.budget,
    p.status,
    d.department_name,
    CONCAT(e.first_name, ' ', e.last_name) AS project_manager,
    COUNT(ep.employee_id) AS team_size
FROM 
    projects p
JOIN 
    departments d ON p.department_id = d.department_id
JOIN 
    employees e ON p.project_manager_id = e.employee_id
LEFT JOIN 
    employee_projects ep ON p.project_id = ep.project_id
GROUP BY 
    p.project_id, p.project_name, p.start_date, p.end_date, p.budget, 
    p.status, d.department_name, project_manager;

-- Create a stored procedure to get department budget summary
DELIMITER //
CREATE PROCEDURE GetDepartmentBudgetSummary()
BEGIN
    SELECT 
        d.department_name,
        d.budget AS department_budget,
        SUM(p.budget) AS total_project_budget,
        d.budget - SUM(IFNULL(p.budget, 0)) AS remaining_budget
    FROM 
        departments d
    LEFT JOIN 
        projects p ON d.department_id = p.department_id
    GROUP BY 
        d.department_id, d.department_name, d.budget;
END //
DELIMITER ;

-- Create a stored procedure to get employees by department
DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartment(IN dept_name VARCHAR(100))
BEGIN
    SELECT 
        e.employee_id,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        e.email,
        e.salary,
        e.hire_date
    FROM 
        employees e
    JOIN 
        departments d ON e.department_id = d.department_id
    WHERE 
        d.department_name = dept_name
    ORDER BY 
        e.salary DESC;
END //
DELIMITER ;
