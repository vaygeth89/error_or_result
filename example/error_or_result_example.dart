import 'package:error_or_result/error_or_result.dart';
import 'package:error_or_result/src/error_or_value.dart';

class Employee {
  int id;
  String name;
  int? managerId;
  Employee({
    required this.id,
    required this.name,
    this.managerId,
  });
}

class Company {
  final String name;
  List<Employee> employees;
  Company({required this.name, required this.employees});
}

//Define any desired error for certain objects or use-cases with the desired code and description
class CompanyDomainErrors {
  static ErrorResult notHeadOfCompany = ErrorResult.validation(
      code: "CompanyError.NotHeadOfCompany",
      description: "The employee is not the head of the company.");
  static ErrorResult isNotRegisteredEmployee = ErrorResult.notFound(
      code: "CompanyError.DoesntExist",
      description: "The employee is not registered in the company.");
}

//Think of this class as Api Service/Repository
class CompanyDomainService {
  static ErrorOr<Employee> getCompanyEmployeeById(int employeeId) {
    var doesEmployeeExist =
        carCompany.employees.map((e) => e.id).toList().remove(employeeId);
    if (doesEmployeeExist) {
      Employee employee = carCompany.employees
          .firstWhere((employee) => employee.id == employeeId);
      return ErrorOr.fromResult(employee);
    }
    return ErrorOr.fromErrors([CompanyDomainErrors.isNotRegisteredEmployee]);
  }

  static ErrorOr<bool> isHeadOfCompany(Employee employee) {
    if (employee.managerId == null && carCompany.employees.contains(employee)) {
      return ErrorOr.fromResult(true);
    }
    return ErrorOr.fromError(CompanyDomainErrors.notHeadOfCompany);
  }
}

//Ali is head of the company
var ali = Employee(id: 1, name: "Ali");
var john = Employee(id: 2, name: "John", managerId: 1);
var alex = Employee(id: 3, name: "Alex", managerId: 2);
var jane = Employee(id: 4, name: "Jane", managerId: 3);
var carCompany =
    Company(name: "SmartX Cars Dealership", employees: [ali, john, alex, jane]);
void main() {
  ErrorOrValue<bool> isBossOfCompanyResult =
      CompanyDomainServiceV2.isHeadOfCompany(john);
  if (isBossOfCompanyResult.isError) {
    print(isBossOfCompanyResult.errors.first.description);
  } else {
    print(isBossOfCompanyResult.result);
  }

  ErrorOrValue<Employee> eResult =
      CompanyDomainServiceV2.getCompanyEmployeeById(2);
  if (eResult.isError) {
    print(eResult.errors.first.code);
  } else {
    print(eResult.result.name);
  }

  // ErrorOr<bool> isHeadOFCompanyResult =
  //     CompanyDomainService.isHeadOfCompany(john);
  // if (isHeadOFCompanyResult.isError) {
  //   print(isHeadOFCompanyResult.firstError.description);
  // } else {
  //   print(isHeadOFCompanyResult.result);
  // }

  // ErrorOr<Employee> employeeResult =
  //     CompanyDomainService.getCompanyEmployeeById(2);
  // if (employeeResult.isError) {
  //   print(employeeResult.firstError.code);
  // } else {
  //   print(employeeResult.result!.name);
  // }
}

class CompanyDomainErrorsV2 {
  static VFailure notHeadOfCompany = VFailure.validation(
      code: "CompanyError.NotHeadOfCompany",
      description: "The employee is not the head of the company.");
  static VFailure isNotRegisteredEmployee = VFailure.notFound(
      code: "CompanyError.DoesntExist",
      description: "The employee is not registered in the company.");
}

class CompanyDomainServiceV2 {
  static ErrorOrValue<Employee> getCompanyEmployeeById(int employeeId) {
    var doesEmployeeExist =
        carCompany.employees.map((e) => e.id).toList().remove(employeeId);
    if (doesEmployeeExist) {
      Employee employee = carCompany.employees
          .firstWhere((employee) => employee.id == employeeId);
      return ErrorOrValue.fromResult(employee);
    }
    return ErrorOrValue.fromErrors(
        [CompanyDomainErrorsV2.isNotRegisteredEmployee]);
  }

  static ErrorOrValue<bool> isHeadOfCompany(Employee employee) {
    if (employee.managerId == null && carCompany.employees.contains(employee)) {
      return ErrorOrValue.fromResult(true);
    }
    return ErrorOrValue.fromErrors([CompanyDomainErrorsV2.notHeadOfCompany]);
  }
}
