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


/** This is an auto generated class representing the Service type in your schema. */
@immutable
class Service extends Model {
  static const classType = const _ServiceModelType();
  final String id;
  final double? _servicelat;
  final double? _servicelong;
  final String? _name;
  final String? _description;
  final String? _rbmqchanel;
  final List<ServiceResponse>? _response;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ServiceModelIdentifier get modelIdentifier {
      return ServiceModelIdentifier(
        id: id
      );
  }
  
  double get servicelat {
    try {
      return _servicelat!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get servicelong {
    try {
      return _servicelong!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
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
  
  String? get description {
    return _description;
  }
  
  String get rbmqchanel {
    try {
      return _rbmqchanel!;
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
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Service._internal({required this.id, required servicelat, required servicelong, required name, description, required rbmqchanel, response, createdAt, updatedAt}): _servicelat = servicelat, _servicelong = servicelong, _name = name, _description = description, _rbmqchanel = rbmqchanel, _response = response, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Service({String? id, required double servicelat, required double servicelong, required String name, String? description, required String rbmqchanel, List<ServiceResponse>? response}) {
    return Service._internal(
      id: id == null ? UUID.getUUID() : id,
      servicelat: servicelat,
      servicelong: servicelong,
      name: name,
      description: description,
      rbmqchanel: rbmqchanel,
      response: response != null ? List<ServiceResponse>.unmodifiable(response) : response);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Service &&
      id == other.id &&
      _servicelat == other._servicelat &&
      _servicelong == other._servicelong &&
      _name == other._name &&
      _description == other._description &&
      _rbmqchanel == other._rbmqchanel &&
      DeepCollectionEquality().equals(_response, other._response);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Service {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("servicelat=" + (_servicelat != null ? _servicelat!.toString() : "null") + ", ");
    buffer.write("servicelong=" + (_servicelong != null ? _servicelong!.toString() : "null") + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("rbmqchanel=" + "$_rbmqchanel" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Service copyWith({double? servicelat, double? servicelong, String? name, String? description, String? rbmqchanel, List<ServiceResponse>? response}) {
    return Service._internal(
      id: id,
      servicelat: servicelat ?? this.servicelat,
      servicelong: servicelong ?? this.servicelong,
      name: name ?? this.name,
      description: description ?? this.description,
      rbmqchanel: rbmqchanel ?? this.rbmqchanel,
      response: response ?? this.response);
  }
  
  Service.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _servicelat = (json['servicelat'] as num?)?.toDouble(),
      _servicelong = (json['servicelong'] as num?)?.toDouble(),
      _name = json['name'],
      _description = json['description'],
      _rbmqchanel = json['rbmqchanel'],
      _response = json['response'] is List
        ? (json['response'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ServiceResponse.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'servicelat': _servicelat, 'servicelong': _servicelong, 'name': _name, 'description': _description, 'rbmqchanel': _rbmqchanel, 'response': _response?.map((ServiceResponse? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'servicelat': _servicelat, 'servicelong': _servicelong, 'name': _name, 'description': _description, 'rbmqchanel': _rbmqchanel, 'response': _response, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<ServiceModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<ServiceModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField SERVICELAT = QueryField(fieldName: "servicelat");
  static final QueryField SERVICELONG = QueryField(fieldName: "servicelong");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField RBMQCHANEL = QueryField(fieldName: "rbmqchanel");
  static final QueryField RESPONSE = QueryField(
    fieldName: "response",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'ServiceResponse'));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Service";
    modelSchemaDefinition.pluralName = "Services";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Service.SERVICELAT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Service.SERVICELONG,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Service.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Service.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Service.RBMQCHANEL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Service.RESPONSE,
      isRequired: false,
      ofModelName: 'ServiceResponse',
      associatedKey: ServiceResponse.SERVICE
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

class _ServiceModelType extends ModelType<Service> {
  const _ServiceModelType();
  
  @override
  Service fromJson(Map<String, dynamic> jsonData) {
    return Service.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Service';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Service] in your schema.
 */
@immutable
class ServiceModelIdentifier implements ModelIdentifier<Service> {
  final String id;

  /** Create an instance of ServiceModelIdentifier using [id] the primary key. */
  const ServiceModelIdentifier({
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
  String toString() => 'ServiceModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ServiceModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}