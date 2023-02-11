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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the ServiceResponse type in your schema. */
@immutable
class ServiceResponse extends Model {
  static const classType = const _ServiceResponseModelType();
  final String id;
  final Provider? _serviceprovider;
  final Service? _service;
  final double? _providerlat;
  final double? _providerlong;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ServiceResponseModelIdentifier get modelIdentifier {
      return ServiceResponseModelIdentifier(
        id: id
      );
  }
  
  Provider? get serviceprovider {
    return _serviceprovider;
  }
  
  Service? get service {
    return _service;
  }
  
  double get providerlat {
    try {
      return _providerlat!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get providerlong {
    try {
      return _providerlong!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const ServiceResponse._internal({required this.id, serviceprovider, service, required providerlat, required providerlong, createdAt, updatedAt}): _serviceprovider = serviceprovider, _service = service, _providerlat = providerlat, _providerlong = providerlong, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ServiceResponse({String? id, Provider? serviceprovider, Service? service, required double providerlat, required double providerlong}) {
    return ServiceResponse._internal(
      id: id == null ? UUID.getUUID() : id,
      serviceprovider: serviceprovider,
      service: service,
      providerlat: providerlat,
      providerlong: providerlong);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ServiceResponse &&
      id == other.id &&
      _serviceprovider == other._serviceprovider &&
      _service == other._service &&
      _providerlat == other._providerlat &&
      _providerlong == other._providerlong;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ServiceResponse {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("serviceprovider=" + (_serviceprovider != null ? _serviceprovider!.toString() : "null") + ", ");
    buffer.write("service=" + (_service != null ? _service!.toString() : "null") + ", ");
    buffer.write("providerlat=" + (_providerlat != null ? _providerlat!.toString() : "null") + ", ");
    buffer.write("providerlong=" + (_providerlong != null ? _providerlong!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ServiceResponse copyWith({Provider? serviceprovider, Service? service, double? providerlat, double? providerlong}) {
    return ServiceResponse._internal(
      id: id,
      serviceprovider: serviceprovider ?? this.serviceprovider,
      service: service ?? this.service,
      providerlat: providerlat ?? this.providerlat,
      providerlong: providerlong ?? this.providerlong);
  }
  
  ServiceResponse.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _serviceprovider = json['serviceprovider']?['serializedData'] != null
        ? Provider.fromJson(new Map<String, dynamic>.from(json['serviceprovider']['serializedData']))
        : null,
      _service = json['service']?['serializedData'] != null
        ? Service.fromJson(new Map<String, dynamic>.from(json['service']['serializedData']))
        : null,
      _providerlat = (json['providerlat'] as num?)?.toDouble(),
      _providerlong = (json['providerlong'] as num?)?.toDouble(),
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'serviceprovider': _serviceprovider?.toJson(), 'service': _service?.toJson(), 'providerlat': _providerlat, 'providerlong': _providerlong, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'serviceprovider': _serviceprovider, 'service': _service, 'providerlat': _providerlat, 'providerlong': _providerlong, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryModelIdentifier<ServiceResponseModelIdentifier> MODEL_IDENTIFIER = QueryModelIdentifier<ServiceResponseModelIdentifier>();
  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField SERVICEPROVIDER = QueryField(
    fieldName: "serviceprovider",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Provider'));
  static final QueryField SERVICE = QueryField(
    fieldName: "service",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: 'Service'));
  static final QueryField PROVIDERLAT = QueryField(fieldName: "providerlat");
  static final QueryField PROVIDERLONG = QueryField(fieldName: "providerlong");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ServiceResponse";
    modelSchemaDefinition.pluralName = "ServiceResponses";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ServiceResponse.SERVICEPROVIDER,
      isRequired: false,
      targetNames: ['providerResponseId'],
      ofModelName: 'Provider'
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ServiceResponse.SERVICE,
      isRequired: false,
      targetNames: ['serviceResponseId'],
      ofModelName: 'Service'
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ServiceResponse.PROVIDERLAT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ServiceResponse.PROVIDERLONG,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
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

class _ServiceResponseModelType extends ModelType<ServiceResponse> {
  const _ServiceResponseModelType();
  
  @override
  ServiceResponse fromJson(Map<String, dynamic> jsonData) {
    return ServiceResponse.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'ServiceResponse';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [ServiceResponse] in your schema.
 */
@immutable
class ServiceResponseModelIdentifier implements ModelIdentifier<ServiceResponse> {
  final String id;

  /** Create an instance of ServiceResponseModelIdentifier using [id] the primary key. */
  const ServiceResponseModelIdentifier({
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
  String toString() => 'ServiceResponseModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ServiceResponseModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}