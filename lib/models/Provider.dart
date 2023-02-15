/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Provider type in your schema. */
@immutable
class Provider extends Model {
  static const classType = const _ProviderModelType();
  final String id;
  final String? _name;
  final List<ServiceResponse>? _response;
  final List<ServiceReport>? _report;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ProviderModelIdentifier get modelIdentifier {
      return ProviderModelIdentifier(
        id: id
      );
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<ServiceResponse>? get response {
    return _response;
  }
  
  List<ServiceReport>? get report {
    return _report;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Provider._internal({required this.id, required name, response, report, createdAt, updatedAt}): _name = name, _response = response, _report = report, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Provider({String? id, required String name, List<ServiceResponse>? response, List<ServiceReport>? report}) {
    return Provider._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      response: response != null ? List<ServiceResponse>.unmodifiable(response) : response,
      report: report != null ? List<ServiceReport>.unmodifiable(report) : report);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Provider &&
      id == other.id &&
      _name == other._name &&
      DeepCollectionEquality().equals(_response, other._response) &&
      DeepCollectionEquality().equals(_report, other._report);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Provider {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Provider copyWith({String? name, List<ServiceResponse>? response, List<ServiceReport>? report}) {
    return Provider._internal(
      id: id,
      name: name ?? this.name,
      response: response ?? this.response,
      report: report ?? this.report);
  }
  
  Provider.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _response = json['response'] is List
        ? (json['response'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ServiceResponse.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _report = json['report'] is List
        ? (json['report'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ServiceReport.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'response': _response?.map((ServiceResponse? e) => e?.toJson()).toList(), 'report': _report?.map((ServiceReport? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'name': _name, 'response': _response, 'report': _report, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<ProviderModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<ProviderModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField RESPONSE = QueryField(
    fieldName: "response",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'ServiceResponse'));
  static final QueryField REPORT = QueryField(
    fieldName: "report",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'ServiceReport'));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Provider";
    modelSchemaDefinition.pluralName = "Providers";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Provider.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Provider.RESPONSE,
      isRequired: false,
      ofModelName: 'ServiceResponse',
      associatedKey: ServiceResponse.SERVICEPROVIDER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Provider.REPORT,
      isRequired: false,
      ofModelName: 'ServiceReport',
      associatedKey: ServiceReport.SERVICEPROVIDER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _ProviderModelType extends ModelType<Provider> {
  const _ProviderModelType();
  
  @override
  Provider fromJson(Map<String, dynamic> jsonData) {
    return Provider.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Provider';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Provider] in your schema.
 */
@immutable
class ProviderModelIdentifier implements ModelIdentifier<Provider> {
  final String id;

  /** Create an instance of ProviderModelIdentifier using [id] the primary key. */
  const ProviderModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'ProviderModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ProviderModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}